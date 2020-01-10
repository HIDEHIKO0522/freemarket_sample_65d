FactoryBot.define do

  factory :category do
    lady =  Category.find_or_create_by(name: "レディース")
    lady_tops = lady.children.find_or_create_by(name: "トップス")
    name                  {"Tシャツ/カットソー(半袖/袖なし)"}
    ancestry              {"#{lady.id}/#{lady_tops.id}"} 
  end

end