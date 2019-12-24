class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :family_name, :first_name, :family_name_kana, :first_name_kana, :nickname,
            :birthday, :tel, :certification ,presence: true

  has_many :sns_credentials       
  has_one :address
  has_one :card

end