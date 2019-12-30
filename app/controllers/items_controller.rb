class ItemsController < ApplicationController
  def new
    @item = Item.new
    @categorys = Category.where(ancestry: nil)
  end

  def create
    @item = Item.new(item_params)
    @item.status = "出品中"
    if @item.valid? && item_images[:item_images] != nil
      @item.save
      item_images[:item_images].each do |image|
        @item_image = ItemImage.create(image: image, item_id: @item.id)
      end
      redirect_to item_path @item
    else
      @categorys = Category.where(ancestry: nil)
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def category
    @category = Category.find(params[:id])
    @categorys = @category.children
    respond_to do |format|
      format.json
    end
  end


  private
  def item_params
    params.require(:item).permit(:name, :comment, :category_id, :condition, :brand, :size, :price, :arrival_date, :charge, :location, :delivery).merge(seller_id: current_user.id)
  end

  def item_images
    params.require(:item).permit({item_images: []})
  end
end
