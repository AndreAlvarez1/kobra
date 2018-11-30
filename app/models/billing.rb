class Billing < ApplicationRecord
  belongs_to :buyer
  has_many :orders


  enum status: [:notpaid, :paid, :cancel]

end
