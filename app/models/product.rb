class Product < ApplicationRecord
  belongs_to :seller
  has_many :orders, :dependent => :delete_all
  has_many :buyers, through: :orders, :dependent => :delete_all

  validates :price, presence: true
  validates :name, presence: true

  enum category: [:producto, :servicio]



end
