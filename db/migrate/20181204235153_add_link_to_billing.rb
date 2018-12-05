class AddLinkToBilling < ActiveRecord::Migration[5.2]
  def change
    add_column :billings, :link, :string
  end
end
