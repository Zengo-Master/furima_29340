FactoryBot.define do
  factory :item do
    Faker::Config.locale = :ja
    name                {Faker::Lorem.word}
    description         {Faker::Lorem.sentence}
    category            {Faker::Number.between(from: 1, to: 10)}
    status              {Faker::Number.between(from: 1, to: 6)}
    shipping_fee_burden {Faker::Number.between(from: 1, to: 2)}
    shipping_prefecture	{Faker::Number.between(from: 1, to: 47)}
    shipping_days       {Faker::Number.between(from: 1, to: 3)}
    price               {Faker::Number.between(from: 300, to: 9999999)}
    association :user
  end
end