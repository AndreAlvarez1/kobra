class Buyer < ApplicationRecord
  belongs_to :seller
  has_many :billings, :dependent => :delete_all
  has_many :orders, :dependent => :delete_all
  has_many :products, through: :orders, :dependent => :delete_all
  mount_uploader :photo, ImageUploader


  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
end
