class Product < ApplicationRecord
  belongs_to :seller
  has_many :orders
  has_many :buyers, through: :orders

  validates :price, presence: true
  validates :name, presence: true

  enum category: [:producto, :servicio]

  

end
