class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, 
      keys:[:nickname, :email, :password, :family_name, :first_name, :family_name_kana, :first_name_kana, :tel, :birthyear, :birthmonth, :birthday,
        :postal_code, :prefectures, :city, :house_number, :building, :phone_number, :card_company, :number, :security_code, :expiration_month,:expiration_year ])

        # :password_confirmation,
  end
end


