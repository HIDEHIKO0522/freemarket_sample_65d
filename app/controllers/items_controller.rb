class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy]
  
  def index
    @items = Item.limit(10)
    
  end
  
  def new
    @item = Item.new
    @categorys = Category.where(ancestry: nil)
    @prefectures = Prefecture.all
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
      @prefectures = Prefecture.all
      render :new
    end
  end

  def show
    @seller_items = Item.where.not(id: @item.id).where(seller_id: @item.seller_id).order(updated_at: :desc).limit(6)
    @category_items = Item.where.not(id: @item.id).where(category_id: @item.category_id).order(updated_at: :desc).limit(6)
  end

  def category
    @category = Category.find(params[:id])
    @categorys = @category.children
    respond_to do |format|
      format.json
    end
  end

  def destroy
    if current_user.id == @item.seller_id && @item.destroy
      redirect_to user_path(current_user)
    else
      redirect_to item_path @item
    end
  end


  private
  def item_params
    params.require(:item).permit(:name, :comment, :category_id, :condition, :brand, :size, :price, :arrival_date, :charge, :location, :delivery).merge(seller_id: current_user.id)
  end

  def item_images
    params.require(:item).permit({item_images: []})
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
