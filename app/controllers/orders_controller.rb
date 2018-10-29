class OrdersController < ApplicationController


  def new
  end

  def create
    @buyer = Buyer.find(params[:buyer_id])
    @product = Product.find(params[:product])
    @order = Order.create(product: @product, buyer: @buyer)
    @order.save
    redirect_to buyer_products_path(params[:buyer_id])

  end

  def index
    @orders = Order.all

  end


end
