FactoryBot.define do

  factory :user, aliases: [:seller] do
    email                 {"kkk@gmail.com"}
    password              {"00000000"}
    password_confirmation {"00000000"}
  end

  factory :category do
    name                  {"レディース"}
  end

  factory :item do
    name              {"ニットワンピース"}
    comment           {"ニットワンピースです！"}
    condition         {"目立った傷や汚れなし"}
    size              {"M"}
    price             {1400}
    arrival_date      {"2~3日で発送"}
    charge            {"送料込み(出品者負担)"}
    location          {"北海道"}
    delivery          {"らくらくメルカリ便"}
    seller
    category
  end

end