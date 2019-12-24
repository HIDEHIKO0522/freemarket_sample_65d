class ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    binding.pry
    if @item.save
      redirect_to new_item_path
    else
      render :new
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :comment, :condition, :brand, :size, :price, :arrival_date, :charge, :location, :delivery).merge(seller_id: current_user.id, category_id: 1)
  end
end
