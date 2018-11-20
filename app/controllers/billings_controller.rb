class BillingsController < ApplicationController

  def pre_pay
    @buyer = Buyer.find(params[:buyer_id])
    orders = @buyer.orders.where(status: false)
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
      :return_url => "http://localhost:3000/payment/execute",
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
          redirect_url = @payment.links.find{|v| v.method == "REDIRECT" }.href
          redirect_to redirect_url
        else
          ':('
        end
  end

end
