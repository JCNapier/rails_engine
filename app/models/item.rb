class Item < ApplicationRecord 
  belongs_to :merchant

  validates_presence_of :name, 
                        :description, 
                        :unit_price, 
                        :merchant_id

  def self.find_by_name(name)
    where("lower(name) LIKE ?", "%#{name.downcase}%")
    .order(:name)
    .first
  end

  def self.find_by_min_price(price)
    where("unit_price >= ?", (price.to_f))
    .order(:name)
    .first
  end

  def self.find_by_max_price(price)
    where("unit_price <= ?", (price.to_f))
    .first
  end
end