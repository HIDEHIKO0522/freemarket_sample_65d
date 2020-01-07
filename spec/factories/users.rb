FactoryBot.define do

  factory :user, aliases: [:seller] do
    nickname              {"aaa"}
    email                 {"kkk@gmail.com"}
    password              {"aaaa1111"}
    password_confirmation {"aaaa1111"}
    family_name           {"鈴木"}
    first_name            {"太郎"}
    family_name_kana      {"スズキ"}
    first_name_kana       {"タロウ"}
    birthyear             {"1900"}
    birthmonth            {"12"}
    birthday              {"25"}
    tel                   {"1234567890"}
    image                 {"user.jpg"}
    point                 {"1234567890"}
    sales                 {"1234567890"}
    certification         {"id.jpg"}
  end
  
end