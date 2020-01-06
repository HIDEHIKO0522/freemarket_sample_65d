class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  belongs_to :user, optional: true



  PHONE_NUMBER      = /\A\d{10}\z|\A\d{11}\z/
  POST_NUMBER       = /\A\d{3}[-]\d{4}\z|^\d{3}[-]\d{2}\z|^\d{3}\z|^\d{5}\z|^\d{7}\z/
  validates :postal_code,             presence: true, format: {maximum: 100},format: { with: POST_NUMBER }
  validates :prefectures,             presence: true, length: {maximum: 100}
  validates :city,                    presence: true, length: {maximum: 50}
  validates :house_number,            presence: true, length: {maximum: 100}
  validates :building,                length: {maximum: 50}
  validates :phone_number,            format: { with: PHONE_NUMBER }
  
end


