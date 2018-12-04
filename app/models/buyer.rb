class Buyer < ApplicationRecord
  belongs_to :seller
  has_many :billings
  has_many :orders
  has_many :products, through: :orders
  mount_uploader :photo, ImageUploader


  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
end
