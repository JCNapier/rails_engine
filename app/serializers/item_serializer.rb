class ItemSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :description, :unit_price, :merchant_id

  belongs_to :merchant
end
