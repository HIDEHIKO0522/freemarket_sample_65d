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


    50.times do |n|
      name = Faker::JapaneseMedia::DragonBall.character
      email = Faker::Internet.email
      password = Faker::Internet.password
      family_name = Gimei.last.kanji
      first_name = Gimei.first.kanji
      family_name_kana = Gimei.last.katakana
      first_name_kana = Gimei.first.katakana
      birthyear = Faker::Number.between(from: 1960, to: 2019)
      birthmonth = Faker::Number.between(from: 1, to: 12)
      birthday = Faker::Number.between(from: 1, to: 31) 
      postal_code = Faker::Number.number(digits: 7)
      prefectures = Faker::Number.between(from: 1, to: 48)
      city = Gimei.city.kanji
      house_number = Gimei.town.kanji
      phone_number = Faker::Number.leading_zero_number(digits: 11)  
      number = Faker::Number.number(digits: 15)
      security_code = Faker::Number.within(range: 100..9999)
      expiration_month = Faker::Number.between(from: 1, to: 12)
      expiration_year = Faker::Number.between(from: 19, to: 29)



      User.create!(nickname: name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   family_name: family_name,
                   first_name: first_name,
                   family_name_kana: family_name_kana,
                   first_name_kana: first_name_kana,
                   birthyear: birthyear,
                   birthmonth: birthmonth,
                   birthday: birthday,      
                  )
      Address.create!(postal_code: postal_code,
                      prefectures: prefectures,
                      city: city,
                      house_number: house_number,
                      phone_number: phone_number, 
                      )
      Card.create!(number: number,
                    security_code: security_code,
                    expiration_month: expiration_month,
                    expiration_year: expiration_year,
                    )                
    end
    
  


    