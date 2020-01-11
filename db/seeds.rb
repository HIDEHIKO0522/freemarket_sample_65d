lady = Category.create(name: "レディース")
  lady_tops = lady.children.create(name: "トップス")
    lady_t_shirt = lady_tops.children.create(name: "Tシャツ/カットソー(半袖/袖なし)")
    lady_polo_shirts = lady_tops.children.create(name: "ポロシャツ")
  lady_jacket = lady.children.create(name: "ジャケット/アウター")
    lady_tailored_jacket = lady_jacket.children.create(name: "テーラードジャケット")
    lady_leather_jacket = lady_jacket.children.create(name: "レザージャケット")

men = Category.create(name: "メンズ")
  men_tops = men.children.create(name: "トップス")
    men_t_shirt = men_tops.children.create(name: "Tシャツ/カットソー(半袖/袖なし)")
    men_polo_shirts = men_tops.children.create(name: "ポロシャツ")
  men_jacket = men.children.create(name: "ジャケット/アウター")
    men_tailored_jacket = men_jacket.children.create(name: "テーラードジャケット")
    men_leather_jacket = men_jacket.children.create(name: "レザージャケット")


   
    
  


    