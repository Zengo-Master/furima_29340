FactoryBot.define do
  factory :purchase_address do
    Faker::Config.locale = :ja
    buyer_postal_code   {Faker::Address.postcode}
    buyer_prefecture_id {Faker::Number.between(from: 1, to: 47)}
    buyer_city          {Faker::Lorem.word}
    buyer_home_number   {Faker::Lorem.word}
    buyer_building_name {Faker::Lorem.word}
    buyer_phone_number	{Faker::Number.number(11)}
    association :purchase
  end
end