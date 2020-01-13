FactoryBot.define do

  factory :card do
    number                  {"Faker::Number.number(digits: 15)"}
    security_code           {"Faker::Number.within(range: 100..9999)"}
    user_id                  {"1"}
    expiration_month         {"Faker::Number.between(from: 1, to: 12)"}
    expiration_year          {"Faker::Number.between(from: 19, to: 29)"}
  end

end