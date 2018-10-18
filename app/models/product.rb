class Product < ApplicationRecord
  belongs_to :seller
  has_many :orders
  has_many :buyers, through: :orders
end
