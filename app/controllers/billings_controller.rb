
class BillingsController < ApplicationController

  def index
    @billings = Billing.all
  end


  def pre_pay
    @buyer = Buyer.find(params[:buyer_id])
    orders = @buyer.orders.where(status: 0)
    total = orders.pluck("price*quantity").sum()
    items = orders.map do |order|
      item = {}
      item[:name] = order.product.name
      item[:sku] = order.id.to_s
      item[:price] = order.price.to_s
      item[:currency] = 'USD'
      item[:quantity] = order.quantity
      item
    end

    @payment = PayPal::SDK::REST::Payment.new({
    :intent =>  "sale",
    :payer =>  {
      :payment_method =>  "paypal" },
    :redirect_urls => {
      :return_url => "http://localhost:3000/billings/execute/#{@buyer.id}",
      :cancel_url => "http://localhost:3000/" },
    :transactions =>  [{
      :item_list => {
        :items => items
      },
      :amount =>  {
        :total =>  total,
        :currency =>  "USD" },
      :description =>  "Carro de Compra KOBRA" }]})

        if @payment.create

          billing = Billing.create(
          buyer: @buyer,
          payment_id: @payment.id
          )

          redirect_url = @payment.links.find{|v| v.method == "REDIRECT" }.href


          orders.map do |order|
            order.status = 1
            order.payment_id = @payment.id
            order.billing_id = billing.id
            order.save
          end

          ExampleMailer.sample_email(@buyer,redirect_url).deliver

          respond_to do |format|
              format.html {redirect_to orders_path}
          end
        else
          ':('
        end
  end



  def execute
    @buyer = Buyer.find(params[:buyer_id])
    paypal_payment = PayPal::SDK::REST::Payment.find(params[:paymentId])
     if paypal_payment.execute(payer_id: params[:PayerID])

       amount = paypal_payment.transactions.first.amount.total

       billing = Billing.find_by(payment_id: params[:paymentId])
       billing.update(
       buyer: @buyer,
       code: paypal_payment.id,
       payment_method: 'paypal',
       amount: amount,
       currency: 'USD',
       status:1
       )

       orders = @buyer.orders.where(status: 1, payment_id: params[:paymentId])
       orders.update_all(status: 2)

       redirect_to pages_success_path, notice: "La compra se realizó con éxito!"
     else
       render plain: "No se puedo generar el cobro en PayPal."
     end

  end

end
