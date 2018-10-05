json.extract! product, :id, :seller_id, :name, :detail, :price, :category, :created_at, :updated_at
json.url product_url(product, format: :json)
