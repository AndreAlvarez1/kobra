class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :buyer, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
