class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id,
             :name,
             :description,
             :unit_price,
             :merchant_id,
             :created_at,
             :updated_at
end
