class Buyer < ApplicationRecord
  belongs_to :seller
  has_many :orders
  has_many :products, through: :orders
  
end
