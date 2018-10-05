class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :seller, foreign_key: true
      t.string :name
      t.text :detail
      t.integer :price
      t.integer :category

      t.timestamps
    end
  end
end
