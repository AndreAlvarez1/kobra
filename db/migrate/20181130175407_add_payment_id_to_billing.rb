class AddPaymentIdToBilling < ActiveRecord::Migration[5.2]
  def change
    add_column :billings, :payment_id, :string
  end
end
