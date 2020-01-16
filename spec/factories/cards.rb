FactoryBot.define do

  factory :card do
    number                   {"4242424242424242"}
    security_code            {"123"}
    user
    expiration_month         {"12"}
    expiration_year          {"2020"}
    token                    {"cus_661f85e8097b1b9668669ba267fb"}
  end

end