class Product < ApplicationRecord
  belongs_to :seller
  has_many :orders, :dependent => :delete_all
  has_many :buyers, through: :orders, :dependent => :delete_all

  validates :price, presence: true
  validates :name, presence: true

  enum category: [:producto, :servicio]

  def basquet_quantity(buyer)
    @basquet_quantity = 0
    @order = Order.where(buyer_id: buyer.id, status: 0, product_id: id).first
    if @order != nil
      @basquet_quantity = @order.quantity
    end
    @basquet_quantity
  end

end
