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
      keys:[:nickname, :email, :password, :password_confirmation, :family_name, :first_name, :family_name_kana, :first_name_kana, :birthyear, :birthmonth, :birthday, :tel,
        :postal_code, :prefectures, :city, :house_number, :type, :building, :phone_number, :type, :number, :security_code, :expiration_month,:expiration_year ])
  end
end


