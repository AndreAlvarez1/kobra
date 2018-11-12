class OrdersController < ApplicationController


  def index
    @seller = current_seller
    @orders = @seller.orders
  end

  def new
  end

  def create
    @buyer = Buyer.find(params[:buyer_id])
    @product = Product.find(params[:product])
    @order = Order.create(product: @product, buyer: @buyer)
    @order.save
    redirect_to buyer_products_path(params[:buyer_id])
  end


  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'La orden fue eliminada con exito.' }
      format.json { head :no_content }
    end
  end


end
