class AddStatusToBilling < ActiveRecord::Migration[5.2]
  def change
    add_column :billings, :status, :integer, default: 0
  end
end
