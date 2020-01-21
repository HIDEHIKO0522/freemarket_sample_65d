class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # extend ActiveHash::Associations::ActiveRecordExtensions
  # belongs_to_active_hash :birthyear
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]
  
  has_many :sns_credentials
  has_one :address
  has_one :card
  has_one :sale

  def self.without_sns_data(auth)
    user = User.where(email: auth.info.email).first

      if user.present?
        sns = SnsCredential.create(
          uid: auth.uid,
          provider: auth.provider,
          user_id: user.id
        )
      else
        user = User.new(
          nickname: auth.info.name,
          email: auth.info.email,
        )
        sns = SnsCredential.new(
          uid: auth.uid,
          provider: auth.provider
        )
      end
      return { user: user ,sns: sns}
    end

  def self.with_sns_data(auth, snscredential)
    user = User.where(id: snscredential.user_id).first
    unless user.present?
      user = User.new(
        nickname: auth.info.name,
        email: auth.info.email,
      )
    end
    return {user: user}
  end

  def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first
    if snscredential.present?
      user = with_sns_data(auth, snscredential)[:user]
      sns = snscredential
    else
      user = without_sns_data(auth)[:user]
      sns = without_sns_data(auth)[:sns]
    end
    return { user: user ,sns: sns}
  end


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

