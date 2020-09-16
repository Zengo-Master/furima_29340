FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.name}
    email                 {Faker::Internet.free_email}
    password              {'1a' + Faker::Internet.password(min_length: 6, max_length: 20)}
    password_confirmation {password}
    family_name           {Gimei.last.kanji}
    first_name	          {Gimei.first.kanji}
    family_name_kana      {Gimei.last.katakana}
    first_name_kana       {Gimei.first.katakana}
    birthday              {Faker::Date.between(from: '1930-01-01', to: '2015-12-31')}
  end
end