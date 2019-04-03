class Billing < ApplicationRecord
  belongs_to :buyer
  has_many :orders, :dependent => :delete_all
  enum status: [:notpaid, :paid, :cancel]
end
