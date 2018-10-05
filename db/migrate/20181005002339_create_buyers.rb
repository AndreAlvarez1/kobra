class CreateBuyers < ActiveRecord::Migration[5.2]
  def change
    create_table :buyers do |t|
      t.references :seller, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :photo
      t.string :phone
      t.string :email
      t.text :detail

      t.timestamps
    end
  end
end
