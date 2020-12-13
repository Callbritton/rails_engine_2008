FactoryBot.define do
  factory :item do
    name { Faker::Games::WorldOfWarcraft.hero }
    description { Faker::Games::WorldOfWarcraft.quote }
    unit_price { Faker::Number.decimal(l_digits: 2) }
    merchant
  end
end
