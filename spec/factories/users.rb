FactoryBot.define do

  factory :user, aliases: [:seller] do
    nickname              {Faker::JapaneseMedia::DragonBall.character}
    email                 {"kkk@gmail.com"}
    password              {"0000aaaa"}
    password_confirmation {"0000aaaa"}
    family_name           {"Gimei.last.kanji"}
    first_name            {"Gimei.first.kanji"}
    family_name_kana      {"Gimei.last.katakana"}
    first_name_kana       {"Gimei.first.katakana"}
    birthyear             {Faker::Number.between(from: 1960, to: 2019)}
    birthmonth            {Faker::Number.between(from: 1, to: 12)}
    birthday              {Faker::Number.between(from: 1, to: 31) }
    tel                   {Faker::Number.leading_zero_number(digits: 11)}
  end
end