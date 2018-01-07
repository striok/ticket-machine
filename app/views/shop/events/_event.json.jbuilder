json.extract! event, :id, :name, :address, :price, :description, :date, :quantity, :created_at, :updated_at
json.url event_url(event, format: :json)
