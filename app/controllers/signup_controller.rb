class SignupController < ApplicationController

  layout 'form_layout'


  # before_action :validates_profile, only: :tel 
  # before_action :validates_tel,     only: :address
  # before_action :validates_address, only: :card

  def registration
    @user = User.new
    @address = Address.new
    @card = Card.new
  end


  def profile_validation
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:family_name] = user_params[:family_name]
    session[:first_name] = user_params[:first_name]
    session[:family_name_kana] = user_params[:family_name_kana]
    session[:first_name_kana] = user_params[:first_name_kana]
    session[:birthdyear] = user_params[:birthyear]
    session[:birthmonth] = user_params[:birthmonth]
    session[:birthday] = user_params[:birthday]

    # post_family_name: "仮登録",
    # post_personal_name: "仮登録",
    # post_family_name_kana: "カリ",
    # post_personal_name_kana: "トウロク",
    # prefecture: '沖縄',
    # city: '那覇市',
    # address: 'テスト',
    # postal_code: '888-8888'


    @user = User.new(
      nickname: session[:nickname], 
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      family_name: session[:family_name], 
      first_name: session[:first_name], 
      family_name_kana: session[:family_name_kana], 
      first_name_kana: session[:first_name_kana], 
      birthyear: session[:birthyear],
      birthmonth: session[:birthmonth],
      birthday: session[:birthday]
    )

    # バリデーションエラーを事前に取得させる（下のunlessでは全て取得できない場合があるため）
    check_user_valid = @user.valid?
    #reCAPTCHA（私はロボットではありませんのアレ）とユーザー、プロフィールのバリデーション判定
    unless verify_recaptcha(model: @user) && check_user_valid
      render 'signup/registration' 
    else
      # 問題がなければsession[:through_first_valid]を宣言して次のページへリダイレクト
      session[:through_profile_validation] = "through_profile_validation"
      redirect_to sms_authentication_signup_index_path
    end
  end

  def sms_authentication
    @address = Address.new
  end



  # postal_code: session[:postal_code], 
      # prefectures: session[:prefectures],
      # city: session[:city],
      # house_number: session[:house_number],
      # tel: session[:tel], 
      # type: session[:type]

  def address_validation
    session[:postal_code] = address_params[:postal_code]
    session[:prefectures] = address_params[:prefectures]
    session[:city] = address_params[:city]
    session[:house_number] = address_params[:house_number]
    session[:user_id] = address_params[:house_number]
    session[:type] = address_params[:type]
    # post_family_name: "仮登録",
    # post_personal_name: "仮登録",
    # post_family_name_kana: "カリ",
    # post_personal_name_kana: "トウロク",
    # prefecture: '沖縄',
    # city: '那覇市',
    # address: 'テスト',
    # postal_code: '888-8888'
  end  

    @address = Address.new(
      postal_code: session[:postal_code], 
      prefectures: session[:prefectures],
      city: session[:city],
      house_number: session[:house_number],
      user_id: session[:user_id],
      type: session[:type]
    )

    # バリデーションエラーを事前に取得させる（下のunlessでは全て取得できない場合があるため）
    check_address_valid = @address.valid?
    #reCAPTCHA（私はロボットではありませんのアレ）とユーザー、プロフィールのバリデーション判定
    unless verify_recaptcha(model: @address) && check_address_valid
      render 'signup/address' 
    else
      # 問題がなければsession[:through_address_validation]を宣言して次のページへリダイレクト
      session[:through_address_validation] = "through_address_validation"
      redirect_to card_signup_index_path
    end
  end

  #ここにカードの記述


  def create
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      birthyear: session[:birthyear],
      birthmonth: session[:birthmonth],
      birthyear: session[:birthyear],
      birthmonth: session[:birthmonth],
      birthday: session[:birthday],
      family_name: session[:family_name],
      first_name: session[:first_name],
      family_name_kana: session[:family_name_kana],
      first_name_kana: session[:first_name_kana]
    #   post_family_name: session[:post_family_name],
    #   post_first_name: session[:post_first_name],
    #   post_family_name_kana: session[:post_family_name_kana],
    #   post_first_name_kana: session[:post_first_name_kana],
    )
    # 万一ユーザーがcreateできなかった場合、全sessionをリセットして登録ページトップへリダイレクト
    unless @user.save
      reset_session
      redirect_to signup_index_path
      return
    end
    # userが作れたらuserに紐づけてprofileを作ります
    @address = Address.create(
      user: @user,
      postal_code: session[:postal_code],
      prefectures: session[:prefectures],
      city: session[:city],
      house_number: session[:house_number],
      tel: session[:tel],

    )
    # 最後のフォームでクレジット認証を行なっているため、ここでカードの顧客情報を作り、userと紐づけてDBに保存する処理を行なっています
    customer = Payjp::Customer.create(card: params[:payjp_token])
    @card = Creditcard.new(user: @user,customer_id: customer.id,card_id: customer.default_card)
    # カード情報まで保存に成功したら全sessionをリセットしてユーザーidのみsessionに預け、完了画面へリダイレクト
    if @card.save
      reset_session
      session[:id] = @user.id
      redirect_to done_signup_index_path
      return 
    else
      #失敗したらsessionを切って登録ページトップへリダイレクト
      reset_session
      redirect_to signup_index_path
    end
  end

  def done
    # session[id]がなければ登録ページトップへリダイレクト
    unless session[:id]
      redirect_to signup_index_path 
      return
    end
    # deviseのメソッドを使ってログイン
    sign_in User.find(session[:id])
  end


  private
  def user_params
    params.require(:user).permit(
      :nickname, 
      :email, 
      :password, 
      :password_confirmation, 
      :family_name, 
      :first_name, 
      :family_name_kana, 
      :first_name_kana,
      :birthyear,
      :birthmonth,
      :birthday
 )
  end

  def address_params
    params.require(:address).permit(
      :postal_code, 
      :prefectures, 
      :city, 
      :house_number, 
      :type, 
 )
  end

  def card_params
    params.require(:card).permit(
      :type, 
      :number, 
      :security_code, 
      :user_id, 
      :expiration_date, 
 )
  end
  # 前のpostアクションで定義されたsessionがなかった場合登録ページトップへリダイレクト
  def redirect_to_index_from_sms
    redirect_to signup_index_path unless session[:through_profile_validation].present? && session[:through_profile_validation] == "through_profile_validation"
  end

end