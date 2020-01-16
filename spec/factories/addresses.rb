FactoryBot.define do

  factory :address do
    postal_code           {Faker::Number.number(digits: 7)}
    prefectures           {Faker::Number.between(from: 1, to: 48)}
    city                  {"Gimei.city.kanji"}
    house_number          {"Gimei.town.kanji"}
    user_id               {"1"}
    building              {"田中ビル"}
    phone_number          {Faker::Number.leading_zero_number(digits: 11)}
  end

end