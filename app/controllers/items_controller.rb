class ItemsController < ApplicationController
  # 本番環境でしか使用しないのでコメントアウト
  # コメントアウトを外せばローカルで使用可能
  # require 'payjp'
  # Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_ACCESS_KEY]
  before_action :set_item, only: [:show, :destroy, :edit, :update, :update_status, :buy, :pay]
  before_action :move_to_sign_in, only: [:buy]
  before_action :item_sold_out?, only: [:buy]
  
  def index
    @items = Item.limit(10)
    
  end
  
  def new
    @item = Item.new
    set_selections(@item)
  end

  def create
    @item = Item.new(item_params)
    @item.status = "出品中"
    if @item.valid? && item_has_1_to_10_images?(@item)
      @item.save
      item_images[:item_images].each do |image|
        @item_image = ItemImage.create(image: image, item_id: @item.id)
      end
      redirect_to item_path @item
    else
      set_selections(@item)
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
       flash[:del] = "商品を削除しました"
       redirect_to mypage_users_path 
    else
      redirect_to item_path @item
    end
  end

  def edit
    if current_user.id == @item.seller_id 
      set_selections(@item)
    else
      redirect_to action: 'show'
    end
  end

  def update
    if @item.update(item_params) && item_has_1_to_10_images?(@item)
      if item_images[:item_images] != nil
        item_images[:item_images].each do |image|
          @item_image = ItemImage.create(image: image, item_id: @item.id)
        end
      end
      redirect_to item_path @item
    else
      set_selections(@item)
      render :edit
    end
  end

  def update_status
    if @item.status == "出品中"
      @item.status = "公開停止中"
    else @item.status == "公開停止中"
      @item.status = "出品中"
    end
    @item.save if current_user.id == @item.seller_id
    redirect_to item_path @item
  end

  def destroy_image
    @image = ItemImage.find(params[:id])
    @item = Item.find(@image.item_id)
    @image.destroy if current_user.id == @item.seller_id
    set_selections(@item)
    render :edit
  end

  def buy

  end

  def pay
    if @item.status == "出品中"
      @item.status = "売却済み"
      sale = Sale.find(@item.seller.sale.id)
      sale.sales += @item.price
      if @item.valid? && sale.valid? && current_user.card.token.present? && @item.seller_id != current_user.id
        @item.save
        sale.save
        # # 本番環境でしか使用しないのでコメントアウト
        # # コメントアウトを外せばローカルで使用可能
        # payjp_charge(@item, current_user)
        redirect_to root_path
      else
        render :buy
      end
    else
      render :buy
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

  def set_selections(item)
    if item.category.present?
      if item.category.has_grand_parent?
        @small_categorys = item.category.siblings
        @middle_categorys = item.category.parent.siblings
      elsif item.category.has_parent?
        @middle_categorys = item.category.siblings
      end
    end
    @categorys = Category.where(ancestry: nil)
    @prefectures = Prefecture.all
  end

  def item_has_1_to_10_images?(item)
    result = false
    if item_images[:item_images].present?
      if item.item_images.present?
        result = true if item_images[:item_images].length + item.item_images.length <= 10
      else
        result = true if item_images[:item_images].length <= 10
      end
    else
      result = true if item.item_images.present?
    end
    return result
  end

  # # 本番環境でしか使用しないのでコメントアウト
  # # コメントアウトを外せばローカルで使用可能
  # def payjp_charge(item, user)
  #   charge = Payjp::Charge.create(
  #     amount: item.price,
  #     customer: user.card.token,
  #     currency: 'jpy'
  #   )
  # end

  def move_to_sign_in
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def item_sold_out?
    item = Item.find(params[:id])
    redirect_to item_path @item if item.status == "売却済み"
  end

end