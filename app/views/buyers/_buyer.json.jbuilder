json.extract! buyer, :id, :seller_id, :first_name, :last_name, :photo, :phone, :email, :detail, :created_at, :updated_at
json.url buyer_url(buyer, format: :json)
