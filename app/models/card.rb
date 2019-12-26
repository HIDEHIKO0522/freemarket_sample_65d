class Card < ApplicationRecord
  # extend ActiveHash::Associations::ActiveRecordExtensions
  # belongs_to_active_hash :expiration_year, :expiration_month  


  belongs_to :user, optional: true

  validates :user_id,                 presence: true
  # validates :type,                    presence: true #カードの種類
  validates :number,                  presence: true, length: {maximum: 20}
  validates :security_code,           presence: true, length: {maximum: 4} 
  validates :expiration_month,        presence: true, length: {maximum: 2}
  validates :expiration_year,         presence: true, length: {maximum: 4}
end
