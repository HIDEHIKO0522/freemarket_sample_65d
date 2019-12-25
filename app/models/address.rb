class Address < ApplicationRecord

  belongs_to :user, optional: true

  POSTAL_CODE_VALID = /\A\d{3}-\d{4}\z/i

  validates :postal_code,             presence: true, length: {maximum: 20}, format: { with: POSTAL_CODE_VALID }
  validates :prefectures,             presence: true, length: {maximum: 20}
  validates :city,                    presence: true, length: {maximum: 20}
  validates :house_number,            presence: true, length: {maximum: 20}
  validates :user_id,                 presence: true
  validates :type,                    presence: true #住所区分
  # validates :post_family_name,        presence: true, length: {maximum: 35}
  # validates :post_personal_name,      presence: true, length: {maximum: 35}
  # validates :post_family_name_kana,   presence: true, length: {maximum: 35}
  # validates :post_personal_name_kana, presence: true, length: {maximum: 35}
  # validates :tel,                                     length: {maximum: 100}
end
