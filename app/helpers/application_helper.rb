module ApplicationHelper

  def current_user_is_seller?(item)
    user_signed_in? && current_user.id == item.seller.id
  end
end
