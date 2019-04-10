class Billing < ApplicationRecord
  belongs_to :buyer
  has_many :orders, :dependent => :delete_all
  enum status: [:notpaid, :paid, :cancel]

  def billing_total
    @billing_total = 0
    orders.each do |order|
      @billing_total += order.price*order.quantity
    end
    @billing_total
  end
end
