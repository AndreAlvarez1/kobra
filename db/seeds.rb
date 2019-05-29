
require 'csv'
require 'faker'

errors = []

# ---------- DESTROYING ALL ----------

# Order.destroy_all
# Seller.destroy

# ---------- CREATING SELLERS ----------

seller1 = Seller.new
seller1.first_name = 'Nicolás'
seller1.last_name = 'Alamo'
seller1.email = 'nicoalamo@gmail.com'
seller1.password = '123123'
seller1.rut = '16.368.107-2'
seller1.phone = '+56 9 9251 3342'
seller1.transbank = '23876341'
seller1.business_type = 'Productos y Servicios Varios'
seller1.account = '341412341'
seller1.bank = 5
seller1.accounttype = 'Cuenta Corriente'
seller1.accountnumber = '158213412'
seller1.accountrut = '16.368.107-2'
seller1.save

seller2 = Seller.new
seller2.first_name = 'André'
seller2.last_name = 'Alvarez'
seller2.email = 'hey@andrealvarez.com'
seller2.password = '123123'
seller2.rut = '16.314.245-1'
seller2.phone = '+56 9 9251 4531'
seller2.transbank = '23876315'
seller2.business_type = 'Productos y Servicios Varios'
seller2.account = '341412611'
seller2.bank = 6
seller2.accounttype = 'Cuenta Corriente'
seller2.accountnumber = '758243412'
seller2.accountrut = '16.314.245-1'
seller2.save

sellers = [seller1, seller2]

puts '2 Sellers created'

# ---------- CREATING BUYERS ----------

buyers_quantity = 40
buyers_quantity.times do
  buyer = Buyer.new
  buyer.first_name = Faker::Name.female_first_name
  buyer.last_name = Faker::Name.last_name
  buyer.email = Faker::Internet.email
  # buyer.rut = rand(8..25).to_s+"."+rand(100..999).to_s+"."+rand(100..999).to_s+"-"+rand(1..9).to_s
  buyer.photo = "https://randomuser.me/api/portraits/female/#{rand(1..99)}.jpg"
  buyer.phone = Faker::PhoneNumber.cell_phone
  buyer.seller_id = rand(1..2)
  buyer.save
end

puts "#{buyers_quantity} Buyers created"


# ---------- CREATING PRODUCTS ----------

products_quantity = 30

products_quantity.times do
  product = Product.new
  product.seller_id = rand(1..2)
  product.name = Faker::Commerce.product_name
  product.detail = Faker::ChuckNorris.fact
  product.price = rand(10..1000)*100
  product.category = rand(0..1)
  product.save
  puts "Product ##{product.id} created"
end

puts "#{products_quantity} Products created"



# ---------- CREATING ORDERS ----------

orders_quantity = buyers_quantity*10
orders_array = []

orders_quantity.times do
  order = Order.new
  order.buyer_id = rand(1..buyers_quantity)
  order.product_id = rand(1..products_quantity)
  order.status = 0
  order.created_at = Faker::Date.between(15.months.ago, Date.today)
  order.quantity = rand(1..10)
  order.price = Product.find_by(id: order.product_id).price*rand(0.9..1.1).to_i
  order.save
  orders_array << order
  puts "Order #{order.id} created"
end

puts "#{orders_array.length} Orders created"


# ---------- CREATING BILLINGS ----------

billings_quantity = buyers_quantity*4
billings_array = []

billings_quantity.times do
  billing = Billing.new
  billing.code = rand(10..99)*452
  billing.payment_method = 'Transferencia'
  billing.currency = "CLP"
  billing.buyer_id = rand(1..buyers_quantity)

  # ASIGNING ALL ORDERS TO BILLINGS WITH SAME BUYER_ID

  orders_to_bill = Order.where(status: 0, buyer_id: billing.buyer_id)
  if orders_to_bill.length > 0
    billing.save
    orders_to_bill.each do |ord|
      ord.status = 1
      ord.billing_id = billing.id
      ord.save
    end
  end

  if billing.orders.count > 0
    max_date_order = billing.orders.order('created_at DESC').first.created_at
    billing.created_at = max_date_order + 86400 * rand(10..60)
    billing.status = 0
    billing.save
    billings_array << billing
    puts "Billing #{billing.id} created"
  end

end

puts "#{Billing.count} Billings created"


# ---------- CREATING MORE ORDERS ----------

orders_quantity = buyers_quantity*5
new_orders_array = []

orders_quantity.times do
  order = Order.new
  order.buyer_id = rand(1..buyers_quantity)
  order.product_id = rand(1..products_quantity)
  order.status = 0
  order.created_at = Faker::Date.between(15.months.ago, Date.today)
  order.quantity = rand(1..10)
  order.price = order.product.price*rand(0.9..1.1)
  order.save
  new_orders_array << order
  puts "Order #{order.id} created"
end

puts "#{new_orders_array.length} Orders created"


# ---------- CREATING PAYMENTS ----------

billings_array.each do |blg|
  random_num = rand(1..2)
  if random_num == 1
    blg.status = 1
    blg.save
    puts "Billing #{blg.id} changed from 'not_paid' to 'paid'"
    blg.orders.each do |ord|
      ord.status = 2
      ord.save
      puts "Order #{ord.id} changed from 'not_paid' to 'paid'"
    end
  end
end




#
#
# #--------------------------PLACES DATABASE POPULATION--------------------------
# csv_text = File.read(Rails.root.join('db', 'seeds_databases', 'places_db.csv'))
# csv_file = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv_file.each do |row|
#   array = row[0].split(";")
#   x = Place.new
#   x.name = array[0]
#   x.address = array[1]
#   x.commune = array[2]
#   x.city = array[3]
#   x.contact_name = array[4]
#   x.contact_cellphone = array[5]
#   x.contact_email = array[6]
#   x.save
#   puts "Errors: #{x.errors.messages}"
#   errors << x.errors.messages
#   puts "Places with Name: #{x.name} has been saved"
# end
#
# puts "There are now #{Place.count} rows in the Places table"
#
# #--------------------------USERS DATABASE POPULATION---------------------------
# csv_text = File.read(Rails.root.join('db', 'seeds_databases', 'users_db.csv'))
# csv_file = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv_file.each do |row|
#   array = row[0].split(";")
#   x = User.new
#   x.rut = array[0]
#   x.first_name = array[1]
#   x.last_name = array[2]
#   x.email = array[3]
#   x.cellphone = array[4]
#   x.gender = array[5]
#   x.city = array[6]
#   x.card_status = array[7].to_s == "true"
#   x.transdata_id = array[8]
#   x.password = '111111'
#   x.save
#   puts "Errors: #{x.errors.messages}"
#   errors << x.errors.messages
#   puts "User #{x.first_name} #{x.last_name} has been saved"
# end
# puts "There are now #{User.count} rows in the Users table"
#
# #--------------------------WASHERS DATABASE POPULATION---------------------------
# csv_text = File.read(Rails.root.join('db', 'seeds_databases', 'washers_db.csv'))
# csv_file = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv_file.each do |row|
#   array = row[0].split(";")
#   x = Washer.new
#   x.rut = array[0]
#   x.first_name = array[1]
#   x.last_name = array[2]
#   x.email = array[3]
#   x.cellphone = array[4]
#   x.city = array[5]
#   x.role = array[6].to_i
#   x.password = '111111'
#   x.save
#   puts "Errors: #{x.errors.messages}"
#   errors << x.errors.messages
#   puts "Washer #{x.first_name} #{x.last_name} has been saved"
# end
# puts "There are now #{Washer.count} rows in the Washers table"
#
# #--------------------------WASH_TYPES DATABASE POPULATION---------------------------
# csv_text = File.read(Rails.root.join('db', 'seeds_databases', 'wash_types_db.csv'))
# csv_file = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv_file.each do |row|
#   array = row[0].split(";")
#   x = WashType.new
#   x.code = array[0]
#   x.name = array[1]
#   x.description = array[2]
#   x.save
#   puts "Errors: #{x.errors.messages}"
#   errors << x.errors.messages
#   puts "Wash_type #{x.name} has been saved"
# end
# puts "There are now #{WashType.count} rows in the Wash_types table"
#
# #--------------------------VEHICLE_SIZES DATABASE POPULATION---------------------------
# csv_text = File.read(Rails.root.join('db', 'seeds_databases', 'vehicle_sizes_db.csv'))
# csv_file = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv_file.each do |row|
#   array = row[0].split(";")
#   x = VehicleSize.new
#   x.code = array[0]
#   x.name = array[1]
#   x.description = array[2]
#   x.save
#   puts "Errors: #{x.errors.messages}"
#   errors << x.errors.messages
#   puts "Vehicle_size #{x.name} has been saved"
# end
# puts "There are now #{VehicleSize.count} rows in the Vehicle_sizes table"
#
# #--------------------------PRICES DATABASE POPULATION---------------------------
# csv_text = File.read(Rails.root.join('db', 'seeds_databases', 'prices_db.csv'))
# csv_file = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv_file.each do |row|
#   array = row[0].split(";")
#   x = Price.new
#   x.place_id = array[0].to_i
#   x.wash_type_id = array[1].to_i
#   x.vehicle_size_id = array[2].to_i
#   x.gross_amount = array[3].to_i
#   x.save
#   puts "Errors: #{x.errors.messages}"
#   errors << x.errors.messages
#   puts "Price #{x.id} with amount $#{x.gross_amount} has been saved"
# end
# puts "There are now #{Price.count} rows in the Prices table"
#
# # -------------------------VEHICLES DATABASE POPULATION-------------------------
# csv_text = File.read(Rails.root.join('db', 'seeds_databases', 'vehicles_db.csv'))
# csv_file = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv_file.each do |row|
#   array = row[0].split(";")
#   x = Vehicle.new
#   x.patent = array[0]
#   x.vehicle_type = array[1]
#   x.brand = array[2]
#   x.model = array[3]
#   x.color = array[4]
#   x.status = array[5].to_s == "true"
#   x.user_id = array[6].to_i
#   x.vehicle_size_id = array[7].to_i
#   x.place_id = 1
#   x.save
#   puts "Errors: #{x.errors.messages}"
#   errors << x.errors.messages
#   puts "Vehicle with Patent:#{x.patent} saved"
# end
# puts "There are now #{Vehicle.count} rows in the Vehicles table"
#
# # -------------------------RECEIPTS DATABASE POPULATION-------------------------
# csv_text = File.read(Rails.root.join('db', 'seeds_databases', 'receipts_db.csv'))
# csv_file = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv_file.each do |row|
#   array = row[0].split(";")
#   x = Receipt.new
#   x.creation_date = array[0].to_date
#   x.informed_gross_amount = array[1].to_i
#   x.total_discount_amount = array[2].to_i
#   x.sii_status = array[3]
#   x.user_id = array[4].to_i
#   x.save
#   puts "Errors: #{x.errors.messages}"
#   errors << x.errors.messages
#   puts "Receipt w/ ID:#{x.id} and Amount: #{x.informed_gross_amount} has been saved"
# end
# puts "There are now #{Receipt.count} rows in the Receipts table"
#
# # -------------------------PAYMENTS DATABASE POPULATION-------------------------
# csv_text = File.read(Rails.root.join('db', 'seeds_databases', 'payments_db.csv'))
# csv_file = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv_file.each do |row|
# payment_method = ["Transferencia Bancaria","Tarjeta de Crédito", "Efectivo"]
#   array = row[0].split(";")
#   x = Payment.new
#   x.charged_date = array[1].to_date
#   x.paid_amount = array[4].to_i
#   x.method = payment_method[rand(1..3)]
#   x.user_id = rand(1..30)
#   x.receipt_id = rand(1..50)
#   x.save
#   puts "Errors: #{x.errors.messages}"
#   errors << x.errors.messages
#   puts "Payment w/ ID:#{x.id} and Amount: #{x.paid_amount} has been saved"
# end
# puts "There are now #{Payment.count} rows in the Payments table"
#
# # -------------------------CREDIT_NOTES DATABASE POPULATION-------------------------
# csv_text = File.read(Rails.root.join('db', 'seeds_databases', 'credit_notes_db.csv'))
# csv_file = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv_file.each do |row|
#   array = row[0].split(";")
#   x = CreditNote.new
#   x.creation_date = array[0].to_date
#   x.informed_gross_amount = array[1].to_i
#   x.sii_status = array[2]
#   x.receipt_id = array[3].to_i
#   x.save
#   puts "Errors: #{x.errors.messages}"
#   errors << x.errors.messages
#   puts "CreditNote w/ ID:#{x.id} and Amount: #{x.informed_gross_amount} has been saved"
# end
# puts "There are now #{CreditNote.count} rows in the CreditNotes table"
#
# #--------------------------RECONCILIATIONS DATABASE POPULATION---------------------------
# csv_text = File.read(Rails.root.join('db', 'seeds_databases', 'reconciliations_db.csv'))
# csv_file = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv_file.each do |row|
#   array = row[0].split(";")
#   x = Reconciliation.new
#   x.payment_id = array[0].to_i
#   x.receipt_id = array[1].to_i
#   x.amount_assigned_from_payment_to_receipt = array[2].to_i
#   x.save
#   puts "Errors: #{x.errors.messages}"
#   errors << x.errors.messages
#   puts "Reconciliation P#{x.payment_id} & R#{x.receipt_id} for: $#{x.amount_assigned_from_payment_to_receipt} has been saved"
# end
# puts "There are now #{Reconciliation.count} rows in the Reconciliations table"
#
# # -------------------------WASHES DATABASE POPULATION-------------------------
# csv_text = File.read(Rails.root.join('db', 'seeds_databases', 'washes_db.csv'))
# csv_file = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv_file.each do |row|
#   array = row[0].split(";")
#   x = Wash.new
#   x.creation_date = array[0].to_date
#   x.discount_amount = array[1].to_i
#   x.wash_type_id = array[2].to_i
#   x.washer_id = array[3].to_i
#   x.vehicle_id = array[4].to_i
#   x.receipt_id = array[5].to_i
#   x.receipt_assigned_amount_to_wash = array[6].to_i
#   x.save
#   puts "Errors: #{x.errors.messages}"
#   errors << x.errors.messages
#   puts "Wash with ID:#{x.id} and Receipt: #{x.receipt_id} has been saved saved"
# end
# puts "There are now #{Wash.count} rows in the Washes table"
#
# # -------------------------SUMMARY-------------------------
# puts ""
# puts "----------SEED FILE SUMMARY----------"
# puts ""
# puts "-----ERRORS-----"
# puts ""
# print errors
# puts ""
# puts "-----SEED FILE SUMMARY-----"
# puts "There are now #{Place.count} rows in the Places table"
# puts "There are now #{User.count} rows in the Users table"
# puts "There are now #{Washer.count} rows in the Washers table"
# puts "There are now #{WashType.count} rows in the Wash_types table"
# puts "There are now #{VehicleSize.count} rows in the Vehicle_sizes table"
# puts "There are now #{Price.count} rows in the Prices table"
# puts "There are now #{Vehicle.count} rows in the Vehicles table"
# puts "There are now #{Receipt.count} rows in the Receipts table"
# puts "There are now #{Payment.count} rows in the Payments table"
# puts "There are now #{CreditNote.count} rows in the CreditNotes table"
# puts "There are now #{Reconciliation.count} rows in the Reconciliations table"
# puts "There are now #{Wash.count} rows in the Washes table"
