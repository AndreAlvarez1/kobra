class OrdersController < ApplicationController
  before_action :set_order, only: [:edit, :update, :destroy]


  def index
    @seller = current_seller
    @search = @seller.orders.search(params[:q])
    @search.sorts = 'created_at desc' if @search.sorts.empty?
    @orders = @search.result.includes(:buyer)

  end

  def new
  end

  def create
    @buyer = Buyer.find(params[:buyer_id])
    @product = Product.find(params[:product])
    @order = Order.create(product: @product, buyer: @buyer, price: @product.price)
    @order.quantity += 1
    @order.save
    redirect_to buyer_products_path(params[:buyer_id])
  end

  def add
    @buyer = Buyer.find(params[:buyer_id])
    @product = Product.find(params[:product])
    @order = Order.where(status: 0, product_id: @product.id, buyer_id: @buyer.id).first
    @order.quantity += 1
    @order.save
    redirect_to buyer_products_path(params[:buyer_id])
  end

  def substract
    @buyer = Buyer.find(params[:buyer_id])
    @product = Product.find(params[:product])
    @order = Order.where(status: 0, product_id: @product.id, buyer_id: @buyer.id).first
    @order.quantity -= 1
    @order.save
    if @order.quantity == 0
      @order.destroy
    end
    redirect_to buyer_products_path(params[:buyer_id])
  end

  def edit
    @order = Order.find(params[:id])
  end


  # def destroy
  #   @order = Order.find(params[:id])
  #   @order.destroy
  #   respond_to do |format|
  #     format.html { redirect_to request.referrer, notice: 'La orden fue eliminada con exito.' }
  #     format.json { head :no_content }
  #   end
  # end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'La orden fue eliminada con exito.' }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
  end


  def update
    @order = Order.find(params[:id])
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to request.referrer, notice: 'El precio fue modificado con exito.' }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:price)
    end


end
