class SignupController < ApplicationController

  # layout 'form_layout'

  def registration
    @user = User.new
    render layout: false
  end

  def index
    render layout: false
  end

#   def profile_validation
#     session[:nickname] = user_params[:nickname]
#     session[:email] = user_params[:email]
#     session[:password] = user_params[:password]
#     session[:password_confirmation] = user_params[:password_confirmation]
#     session[:family_name] = user_params[:family_name]
#     session[:first_name] = user_params[:first_name]
#     session[:family_name_kana] = user_params[:family_name_kana]
#     session[:first_name_kana] = user_params[:first_name_kana]
#     session[:birthdyear] = user_params[:birthyear]
#     session[:birthmonth] = user_params[:birthmonth]
#     session[:birthday] = user_params[:birthday]
#     session[:tel] = user_params[:tel]
 
#     @user = User.new(
#       nickname: session[:nickname], 
#       email: session[:email],
#       password: session[:password],
#       password_confirmation: session[:password_confirmation],
#       family_name: session[:family_name], 
#       first_name: session[:first_name], 
#       family_name_kana: session[:family_name_kana], 
#       first_name_kana: session[:first_name_kana], 
#       birthyear: session[:birthyear],
#       birthmonth: session[:birthmonth],
#       birthday: session[:birthday]
#     )

#     # バリデーションエラーを事前に取得させる（下のunlessでは全て取得できない場合があるため）
#     check_user_valid = @user.valid?
#     #reCAPTCHA（私はロボットではありませんのアレ）とユーザー、プロフィールのバリデーション判定
#     unless verify_recaptcha(model: @user) && check_user_valid
#       # render 'signup/registration' 
#     else
#       # 問題がなければsession[:through_profile_validation]を宣言して次のページへリダイレクト
#       session[:through_profile_validation] = "through_profile_validation"
#       redirect_to sms_authentication_signup_index_path
#     end
#   end
  

  def sms_authentication
   @sms = User.new
   render layout: false
  end

#   def sms_validation
#     session[:tel] = user_params[:tel]

#     @sms = user.new(tel: session[:tel])

#        # バリデーションエラーを事前に取得させる（下のunlessでは全て取得できない場合があるため）
#        check_sms_valid = @sms.valid?
#        #reCAPTCHA（私はロボットではありませんのアレ）とユーザー、プロフィールのバリデーション判定
#        unless verify_recaptcha(model: @sms) && check_sms_valid
#          render 'signup/sms_authentication' 
#        else
#          # 問題がなければsession[:through_sms_validation]を宣言して次のページへリダイレクト
#          session[:through_sms_validation] = "through_sms_validation"
#          redirect_to address_signup_index_path
#        end
#   end

  def address
    @address = Address.new
  end
  
#   def address_validation
#     session[:postal_code] = address_params[:postal_code]
#     session[:prefectures] = address_params[:prefectures]
#     session[:city] = address_params[:city]
#     session[:house_number] = address_params[:house_number]
#     session[:user_id] = address_params[:house_number]
#     session[:type] = address_params[:type]
    
#     @address = Address.new(
#       postal_code: session[:postal_code], 
#       prefectures: session[:prefectures],
#       city: session[:city],
#       house_number: session[:house_number],
#       user_id: session[:user_id],
#       type: session[:type]
#     )

#     # バリデーションエラーを事前に取得させる（下のunlessでは全て取得できない場合があるため）
#     check_address_valid = @address.valid?
#     #reCAPTCHA（私はロボットではありませんのアレ）とユーザー、プロフィールのバリデーション判定
#     unless verify_recaptcha(model: @address) && check_address_valid
#       render 'signup/address' 
#     else
#       # 問題がなければsession[:through_address_validation]を宣言して次のページへリダイレクト
#       session[:through_address_validation] = "through_address_validation"
#       redirect_to card_signup_index_path
#     end
#   end

  def card
    @card = Card.new
  end  

#   def card_validation
#     session[:user_id] = card_params[:user_id]
#     session[:type] = card_params[:type]
#     session[:number] = card_params[:number]
#     session[:security_code] = card_params[:security_code]
#     session[:expiration_month] = card_params[:expiration_month]
#     session[:expiration_year] = card_params[:expiration_year]
  
#     @card = Card.new(
#       user_id: session[:user_id], 
#       # type: session[:type],
#       number: session[:number],
#       security_code: session[:security_code],
#       expiration_month: session[:expiration_month],
#       expiration_year: session[:expiration_year]
#     )
#     # バリデーションエラーを事前に取得させる（下のunlessでは全て取得できない場合があるため）
#     check_address_valid = @address.valid?
#     #reCAPTCHA（私はロボットではありませんのアレ）とユーザー、プロフィールのバリデーション判定
#     unless verify_recaptcha(model: @card) && check_card_valid
#       render 'signup/card' 
#       else
#       # 問題がなければsession[:through_card_validation]を宣言して次のページへリダイレクト
#       session[:through_card_validation] = "through_card_validation"
#       redirect_to done_signup_index_path
#     end
#   end


#   def create
#     @user = User.new(
#       nickname: session[:nickname],
#       email: session[:email],
#       password: session[:password],
#       password_confirmation: session[:password_confirmation],
#       birthyear: session[:birthyear],
#       birthmonth: session[:birthmonth],
#       birthyear: session[:birthyear],
#       birthmonth: session[:birthmonth],
#       birthyear: session[:birthyear],
#       birthmonth: session[:birthmonth],
#       birthday: session[:birthday],
#       family_name: session[:family_name],
#       first_name: session[:first_name],
#       family_name_kana: session[:family_name_kana],
#       first_name_kana: session[:first_name_kana],
#       tel: session[:tel],
#     )
#     # 万一ユーザーがcreateできなかった場合、全sessionをリセットして登録ページトップへリダイレクト
#     unless @user.save
#       reset_session
#       redirect_to signup_index_path
#       return
#     end

#     @address = Address.create(
#       postal_code: session[:postal_code],
#       prefectures: session[:prefectures],
#       city: session[:city],
#       house_number: session[:house_number]
#     )
#     # 万一ユーザーがcreateできなかった場合、全sessionをリセットして登録ページトップへリダイレクト
#     unless @address.save
#       reset_session
#       redirect_to signup_index_path
#       return
#     end

#     @card = Card.new(
#       user_id: session[:user_id], 
#       # type: session[:type],
#       number: session[:number],
#       security_code: session[:security_code],
#       expiration_month: session[:expiration_month],
#       expiration_year: session[:expiration_year]
#     )
#     # 万一ユーザーがcreateできなかった場合、全sessionをリセットして登録ページトップへリダイレクト
#     unless @card.save
#       reset_session
#       redirect_to signup_index_path
#       return
#     end  
# end


  def done
#     # session[id]がなければ登録ページトップへリダイレクト
#     unless session[:id]
#       redirect_to signup_index_path 
#       return
#     end
#     # deviseのメソッドを使ってログイン
#     sign_in User.find(session[:id])
  end


#   private
#   def user_params
#     params.require(:user).permit(
#       :nickname, 
#       :email, 
#       :password, 
#       :password_confirmation, 
#       :family_name, 
#       :first_name, 
#       :family_name_kana, 
#       :first_name_kana,
#       :birthyear,
#       :birthmonth,
#       :birthday
#     )
#   end

#   def sms_params
#     params.require(:user).permit(:tel )
#   end

#   def address_params
#     params.require(:address).permit(
#       :postal_code, 
#       :prefectures, 
#       :city, 
#       :house_number, 
#       :type
#     )
#   end

#   def card_params
  #   params.require(:card).permit(
  #     # :type, 
  #     :number, 
  #     :security_code, 
  #     :user_id, 
  #     :expiration_month, 
  #     :expiration_year, 
  #   )
  # end
  # # 前のpostアクションで定義されたsessionがなかった場合登録ページトップへリダイレクト
  # def redirect_to_index_from_sms
  #   redirect_to signup_index_path unless session[:through_profile_validation].present? && session[:through_profile_validation] == "through_profile_validation"
  # end

end