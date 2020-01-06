class SignupController < ApplicationController

  def index
    render layout: false
  end
  
  def registration
    @user = User.new
    render layout: false
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
    session[:birthyear] = user_params[:birthyear]
    session[:birthmonth] = user_params[:birthmonth]
    session[:birthday] = user_params[:birthday]

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
    check_user_valid = @user.valid?(context: :sms_phone)
    #ユーザー、プロフィールのバリデーション判定
    unless check_user_valid
      # verify_recaptcha(model: @user) && check_user_valid
      flash.now[:alert] = @user.errors.full_messages
      render 'signup/registration' 
    else
      # 問題がなければsession[:through_profile_validation]を宣言して次のページへリダイレクト
      session[:through_profile_validation] = "through_profile_validation"
      redirect_to sms_authentication_signup_index_path

    end
  end
  
  def sms_authentication
   @user = User.new
   render layout: false
  end

  def sms_post
    @user = User.new
    #パラメータが飛んでなかった場合ここでrender
    render sms_authentication_signup_index_path unless  user_params[:tel].present?
    #電話番号を+81~の国際書式に書き換え（そうしないと送れない）
    send_number = user_params[:tel].sub(/\A./,'+81')
    #ランダムに6桁の整数を生成
    sms_number = rand(100000..999999)
    #後の認証用にsessionに預ける
    session[:sms_number] = sms_number
    #環境変数を使ってsms送信準備 
    client = Twilio::REST::Client.new(ENV["TWILLIO_SID"],ENV["TWILLIO_TOKEN"])
    #送信失敗した場合必ずエラーが出るので、例外処理で挙動を分岐
    begin 
      #生成した整数を文章にしたsms送信
      client.api.account.messages.create(from: ENV["TWILLIO_NUMBER"], to: send_number, body: sms_number)
    rescue
      #失敗した場合ここが動く
      render "signup/sms_authentication"
      return false
    end
    #成功した場合、以下のコードが動き、smsの照合画面へと変遷する
    redirect_to sms_confirmation_signup_index_path
  end

  def sms_confirmation
    @user = User.new
    render layout: false
  end

  def sms_check
    @user = User.new
    render layout: false
    #送信された値を代入
    sms_number = user_params[:tel]
    #比較し、一致したら次の登録フォームへ
    if sms_number.to_i == session[:sms_number]
      redirect_to address_signup_index_path
    else
      render "signup/sms_confirmation"
    end
  end
  # def sms_validation
  #   session[:tel] = user_params[:tel]

  #   @user = User.new(tel: session[:tel])
  #        redirect_to address_signup_index_path
  # end

  def address
    @address = Address.new
    render layout: false
  end  
  
  def address_validation
    session[:postal_code] = address_params[:postal_code]
    session[:prefectures] = address_params[:prefectures]
    session[:city] = address_params[:city]
    session[:house_number] = address_params[:house_number]
    session[:user_id] = address_params[:user_id] 
    session[:building] = address_params[:building]  
    session[:phone_number] = address_params[:phone_number] 
    
    @address = Address.new(
      postal_code: session[:postal_code], 
      prefectures: session[:prefectures],
      city: session[:city],
      house_number: session[:house_number],
      user_id: session[:user_id],
      building: "田中ビル",
      phone_number: "08088888888"
    )
    # バリデーションエラーを事前に取得させる（下のunlessでは全て取得できない場合があるため）
    check_address_valid = @address.valid?
    #アドレスのバリデーション判定
    unless check_address_valid
      # verify_recaptcha(model: @address) && check_address_valid
      flash.now[:alert] = @address.errors.full_messages
      render 'signup/address' 
    else
      # 問題がなければsession[:through_address_validation]を宣言して次のページへリダイレクト
      session[:through_address_validation] = "through_address_validation"
      redirect_to card_signup_index_path
    end
  end

  def card
    @card = Card.new
    render layout: false 
  end

  def create
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      birthyear: session[:birthyear],
      birthmonth: session[:birthmonth],
      birthday: session[:birthday],
      family_name: session[:family_name],
      first_name: session[:first_name],
      family_name_kana: session[:family_name_kana],
      first_name_kana: session[:first_name_kana],
      tel: session[:tel]
    )
    #万一ユーザーがcreateできなかった場合、全sessionをリセットして登録ページトップへリダイレクト
    unless @user.save
      reset_session
      flash.now[:alert] = @user.errors.full_messages
      redirect_to signup_index_path
      return
    end

    @address = Address.new(
      user: @user,
      postal_code: session[:postal_code],
      prefectures: session[:prefectures],
      city: session[:city],
      house_number: session[:house_number],
      building: session[:building],
      phone_number: session[:phone_number]
    )
    #万一アドレスがcreateできなかった場合、全sessionをリセットして登録ページトップへリダイレクト
    unless @address.save
      reset_session
      flash.now[:alert] = @address.errors.full_messages
      redirect_to signup_index_path
    end

    session[:number] = card_params[:number]
    session[:security_code] = card_params[:security_code]
    session[:expiration_month] = card_params[:expiration_month]
    session[:expiration_year] = card_params[:expiration_year]
    @card = Card.new(
      user: @user,
      number: session[:number],
      security_code: session[:security_code],
      expiration_month: session[:expiration_month],
      expiration_year: session[:expiration_year]
    )
   #万一カードがcreateできなかった場合、全sessionをリセットして登録ページトップへリダイレクト
    unless @card.save 
      reset_session
      flash.now[:alert] = @card.errors.full_messages
      redirect_to signup_index_path
    end  
      reset_session
      session[:id] = @user.id
      redirect_to done_signup_index_path
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
      :birthday,
      :tel
    )
  end

  def sms_params
    params.require(:user).permit(:tel )
  end

  def address_params
    params.require(:address).permit(:postal_code, :prefectures, :city, :house_number, :building, :phone_number)
  end

  def card_params
    
    params.require(:card).permit(:number, :security_code, :expiration_month, :expiration_year)
  end 
end
