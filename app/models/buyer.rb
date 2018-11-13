class Buyer < ApplicationRecord
  belongs_to :seller
  has_many :orders
  has_many :products, through: :orders

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
end
