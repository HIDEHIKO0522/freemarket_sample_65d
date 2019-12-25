class ItemsController < ApplicationController
  def new
    @item = Item.new
    @item.item_images << ItemImage.new
  end

  def create
    @item = Item.new(item_params)
    if @item.valid? && item_images[:item_images] != nil
      @item.save
      item_images[:item_images].each do |image|
        @item_image = ItemImage.create(image: image, item_id: @item.id)
      end
      redirect_to item_path @item
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end


  private
  def item_params
    params.require(:item).permit(:name, :comment, :category_id, :condition, :brand, :size, :price, :arrival_date, :charge, :location, :delivery).merge(seller_id: current_user.id, status: "出品中")
  end

  def item_images
    params.require(:item).permit({item_images: []})
  end
end
