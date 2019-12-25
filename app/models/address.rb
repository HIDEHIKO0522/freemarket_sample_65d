class Address < ApplicationRecord

  belongs_to :user, optional: true

  POSTAL_CODE_VALID = /\A\d{3}-\d{4}\z/i

  validates :postal_code,             presence: true, length: {maximum: 20}, format: { with: POSTAL_CODE_VALID }
  validates :prefectures,             presence: true, length: {maximum: 20}
  validates :city,                    presence: true, length: {maximum: 20}
  validates :house_number,            presence: true, length: {maximum: 20}
  validates :user_id,                 presence: true
  validates :type,                    presence: true #住所区分
  

end
