class AddAccountAndAccounttypeAndAccountnumberAndBankAndAccountRutToSeller < ActiveRecord::Migration[5.2]
  def change
    add_column :sellers, :account, :string
    add_column :sellers, :accounttype, :integer
    add_column :sellers, :accountnumber, :integer
    add_column :sellers, :bank, :integer
    add_column :sellers, :accountrut, :string
  end
end
