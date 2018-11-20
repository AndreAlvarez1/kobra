class AddBillingToOrder < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :billing, foreign_key: true
  end
end
