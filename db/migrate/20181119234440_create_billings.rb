class CreateBillings < ActiveRecord::Migration[5.2]
  def change
    create_table :billings do |t|
      t.string :code
      t.string :payment_method
      t.integer :amount
      t.string :currency
      t.references :buyer, foreign_key: true

      t.timestamps
    end
  end
end
