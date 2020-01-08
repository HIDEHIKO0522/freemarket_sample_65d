crumb :root do
  link "メルカリ", root_path
end


# 商品関係
crumb :category do
  link "カテゴリー一覧", categorys_path
  parent :root
end

crumb :brand do
  link "ブランド一覧", brands_path
  parent :root
end


# # マイページ
# crumb :mypage do
#   link "マイページ", users_path
#   parent :root
# end

# crumb :notification do
#   link "お知らせ", notification_users_path
#   parent :mypage
# end

# crumb :todo do
#   link "やることリスト", todo_users_path
#   parent :mypage
# end

# crumb :historylike do
#   link "いいね！一覧", history_like_users_path
#   parent :mypage
# end

# crumb :sell do
#   link "出品する", sell_users_path
#   parent :mypage
# end

# crumb :listing_listings do
#   link "出品した商品-出品中", listing_listings_users_path
#   parent :mypage
# end

# crumb :in_progress_listings do
#   link "出品した商品-取引中", in_progress_listings_users_path
#   parent :mypage
# end

# crumb :completed_listings do
#   link "出品した商品-売却済", completed_listings_users_path
#   parent :mypage
# end

# crumb :purchase do
#   link "購入した商品-取引中", purchase_users_path
#   parent :mypage
# end

# crumb :news do
#   link "ニュース一覧", news_users_path
#   parent :mypage
# end

# crumb :history do
#   link "評価一覧", history_users_path
#   parent :mypage
# end

# crumb :help_center do
#   link "ガイド", help_center_users_path
#   parent :mypage
# end

# crumb :support do
#   link "お問い合わせ", support_users_path
#   parent :mypage
# end

# crumb :sales do
#   link "売上・振込申請", sales_users_path
#   parent :mypage
# end

# crumb :point do
#   link "ポイント", point_users_path
#   parent :mypage
# end


# # 設定
# crumb :profile do
#   link "プロフィール", profile_users_path
#   parent :mypage
# end

# crumb :deliver_address do
#   link "発送元・お届け先住所変更", deliver_address_users_path
#   parent :mypage
# end

# crumb :card do
#   link "支払い方法", card_users_path
#   parent :mypage
# end

# crumb :support do
#   link "メール/パスワード", email_password_users_path
#   parent :mypage
# end

# crumb :identification do
#   link "本人情報", identification_users_path
#   parent :mypage
# end

# crumb :identification do
#   link "電話番号の確認", identification_users_path
#   parent :mypage
# end

# # crumb :logout do
# #   link "ログアウト", sales_users_path
# #   parent :mypage
# # end