class SignupController < ApplicationController

  def index
    render layout: false
  end
  
  def registration
    @user = User.new
    render layout: false
  end

  def sms_authentication
   @sms = User.new
   render layout: false
  end

  def address
    @address = Address.new
    render layout: false
  end

  def card
    @card = Card.new
    render layout: false
  end

  def done
    render layout: false
  end

end