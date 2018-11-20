class BillingsController < ApplicationController

  def pre_pay
    @buyer = Buyer.find(params[:buyer_id])
    orders = @buyer.orders.where(status: false)
    total = orders.pluck("price*quantity").sum()
    
  end

end
