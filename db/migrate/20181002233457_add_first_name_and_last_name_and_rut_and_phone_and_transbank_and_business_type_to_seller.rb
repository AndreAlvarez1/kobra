class AddFirstNameAndLastNameAndRutAndPhoneAndTransbankAndBusinessTypeToSeller < ActiveRecord::Migration[5.2]
  def change
    add_column :sellers, :first_name, :string
    add_column :sellers, :last_name, :string
    add_column :sellers, :rut, :string
    add_column :sellers, :phone, :string
    add_column :sellers, :transbank, :string
    add_column :sellers, :business_type, :string
  end
end
