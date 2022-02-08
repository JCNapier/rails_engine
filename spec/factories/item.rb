FactoryBot.define do 
  factory :item do 
    name { Faker::DcComics.name}
    description { Faker::Lorem.paragraph}
    unit_price { Faker::Number.within(range: 1..50 )}
    association :merchant, factory: :merchant
  end
end