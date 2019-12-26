FactoryBot.define do

  factory :address do
    postal_code           {"111-0000"}
    prefectures           {"岩手県"}
    city                  {"盛岡市中央"}
    house_number          {"1-11-1"}
    user_id               {"1"}
    type                  {"2"}
    building              {"田中ビル"}
    phone_number          {"08011111111"}
  end

end