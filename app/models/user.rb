class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # extend ActiveHash::Associations::ActiveRecordExtensions
  # belongs_to_active_hash :birthyear
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
         
  has_many :sns_credentials       
  has_one :address
  has_one :card      
  has_one :sale

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  PASSWORD_VALIDATION = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{7,128}+\z/i  

  validates :nickname,                presence: true, length: {maximum: 50}
  validates :email,                   presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password,                presence: true, length: {minimum: 7, maximum: 128},format: { with: PASSWORD_VALIDATION }
  validates :password_confirmation,   presence: true, length: {minimum: 7, maximum: 128}
  validates :family_name,             presence: true, length: {maximum: 50}
  validates :first_name,              presence: true, length: {maximum: 50}
  validates :family_name_kana,        presence: true, length: {maximum: 50}
  validates :first_name_kana,         presence: true, length: {maximum: 50}
  validates :birthyear,               presence: true, length: {maximum: 50}
  validates :birthmonth,              presence: true, length: {maximum: 50}
  validates :birthday,                presence: true, length: {maximum: 50}
  validates :tel,                     presence: true, length: {maximum: 100},on: :sms_phone

end

