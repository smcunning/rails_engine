FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Books::Lovecraft.sentence }
    unit_price { Faker::Number.number(digits: 5) }
    merchant
  end
end
