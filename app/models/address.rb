class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  belongs_to :user, optional: true

  POSTAL_CODE_VALID = /\A\d{3}-\d{4}\z/i
  validates :user_id,                 presence: true
  validates :postal_code,             presence: true, length: {maximum: 20}, format: { with: POSTAL_CODE_VALID }
  validates :prefectures,             presence: true, length: {maximum: 20}
  validates :city,                    presence: true, length: {maximum: 20}
  validates :house_number,            presence: true, length: {maximum: 20}
  validates :type,                    presence: true #住所区分
  

end
