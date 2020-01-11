class UsersController < ApplicationController
  

  def show
    @user = User.find(params[:id])
    @sell_items = Item.where(seller_id: @user.id).order(updated_at: :desc)
  end

  def logout
  end  

  def card_registration
  end
  
  def card_information
  end  

end
