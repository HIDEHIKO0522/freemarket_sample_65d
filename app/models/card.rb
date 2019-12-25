class Card < ApplicationRecord

  belongs_to :user, optional: true

  validates :type,                    presence: true #カードの種類
  validates :number,                  presence: true
  validates :security_code,           presence: true
  validates :user_id,                 presence: true
  validates :expiration_date,         presence: true
end
