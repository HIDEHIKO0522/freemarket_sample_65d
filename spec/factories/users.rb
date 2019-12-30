FactoryBot.define do

  factory :user do
    nickname              {"hanap"}
    email                 {"kkk@gmail.com"}
    password              {"a000efg"}
    password_confirmation {"a000efg"}
    family_name           {"山田"}
    first_name            {"花子"}
    family_name_kana      {"ヤマダ"}
    first_name_kana       {"ハナコ"}
    birthyear             {"2000"}
    birthmonth            {"05"}
    birthday              {"15"}
    tel                   {"08011112222"}
  end

end