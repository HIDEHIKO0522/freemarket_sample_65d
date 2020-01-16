module ApplicationHelper

  def current_user_is_seller?(item)
    if user_signed_in?
      result = true if current_user.id == item.seller.id
    else
      result = false
    end
    return result
  end
end
