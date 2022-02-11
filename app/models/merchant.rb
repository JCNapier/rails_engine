class Merchant < ApplicationRecord 
  has_many :items

  validates_presence_of :name

  def self.find_by_name(name) 
    where("lower(name) like ?", "%#{name.downcase}%")
    .order(:name)
    .limit(5)
  end
end