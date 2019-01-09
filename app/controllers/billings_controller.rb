
class BillingsController < ApplicationController

  def index
    @seller = current_seller
    @search = @seller.billings.search(params[:q])
    @billings = @search.result.includes(:buyer)
  end


  def pre_pay
    @buyer = Buyer.find(params[:buyer_id])
    orders = @buyer.orders.where(status: 0)
    total = orders.pluck("price*quantity").sum()


    billing = Billing.create(
          buyer: @buyer,
          )
            orders.map do |order|
            order.status = 1
            order.payment_id = billing.id
            order.billing_id = billing.id
            order.save
          end

          ExampleMailer.sample_email(@buyer,billing.link,current_seller,billing).deliver

          respond_to do |format|
              format.html {redirect_to billings_path, notice: 'Kobro enviado con exito.'}
          end
  end

    def rekobrar
      @billing = Billing.find(params[:id])
      ExampleMailer.sample_email(@billing.buyer,@billing.link,current_seller,@billing).deliver

      respond_to do |format|
          format.html {redirect_to billings_path, notice: 'Kobro RE-enviado'}
      end
    end


  def paid
    billing = Billing.find(params[:id])
    billing.update(status: 1)

    respond_to do |format|
        format.html {redirect_to billings_path, notice: 'Billing pagado.'}
    end

  end




end
