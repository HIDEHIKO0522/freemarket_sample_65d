require 'rails_helper'

describe ItemsController do

  let(:category) { create(:category) }
  let(:another_category) { create(:category, name: "メンズ") }
  let(:user) { create(:user) }
  let(:another_user) { create(:user, email: "lll@gmail.com") }
  let(:item) { build(:item) }
  let(:image1) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/images/test_image.jpg')) }
  let(:image2) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/images/test_image.jpg')) }
  let(:image3) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/images/test_image.jpg')) }
  let(:image4) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/images/test_image.jpg')) }
  let(:image5) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/images/test_image.jpg')) }
  let(:image6) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/images/test_image.jpg')) }
  let(:image7) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/images/test_image.jpg')) }
  let(:image8) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/images/test_image.jpg')) }
  let(:image9) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/images/test_image.jpg')) }
  let(:image10) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/images/test_image.jpg')) }
  let(:image11) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/images/test_image.jpg')) }
  let(:item_images_2) { [image1, image2] }
  let(:item_images_11) { [image1, image2, image3, image4, image5, image6, image7, image8, image9, image10, image11] }
  let(:params) {
    { seller_id: user.id,
      item: {
        name: item.name,
        comment: item.comment,
        condition: item.condition,
        size: item.size,
        price: item.price,
        arrival_date: item.arrival_date,
        charge: item.charge,
        location: item.location,
        delivery: item.delivery,
        category_id: category.id,
        item_images: item_images_2
      }
    }
  }
  let(:invalid_params) {
    { seller_id: user.id,
      item: {
        name: nil,
        comment: item.comment,
        condition: item.condition,
        size: item.size,
        price: item.price,
        arrival_date: item.arrival_date,
        charge: item.charge,
        location: item.location,
        delivery: item.delivery,
        category_id: category.id,
        item_images: item_images_2
      }
    }
  }
  let(:created_item) { create(:item, seller: user, category: category) }
  let(:created_item_image) { create(:item_image, item: created_item) }
  let(:another_seller_item) { create(:item, seller: another_user, category: category) }
  let(:another_seller_item_image) { create(:item_image, item: another_seller_item) }

  describe '#create' do

    context 'log in' do
      before do
        login user
      end

      context 'can save' do
        subject {
          post :create,
          params: params
        }
        it 'count up item' do
          expect{ subject }.to change(Item, :count).by(1)
        end

        it 'count up item image' do
          expect{ subject }.to change(ItemImage, :count).by(2)
        end

        it 'redirects to item_path' do
          subject
          item = Item.order(updated_at: :desc).limit(1)[0]
          expect(response).to redirect_to(item_path(item))
        end
      end

      context 'can not save' do
        subject {
          post :create,
          params: invalid_params
        }
        it 'does not count up' do
          expect{ subject }.not_to change(Item, :count)
        end

        it 'does not count up without item_images' do
          expect{
            post :create,
            params: {
              seller_id: user.id,
              item: {
                name: item.name,
                comment: item.comment,
                condition: item.condition,
                size: item.size,
                price: item.price,
                arrival_date: item.arrival_date,
                charge: item.charge,
                location: item.location,
                delivery: item.delivery,
                category_id: category.id,
              }
            }
          }.not_to change(Item, :count)
        end

        it 'does not count up with more than ten item_images' do
          expect{
            post :create,
            params: {
              seller_id: user.id,
              item: {
                name: item.name,
                comment: item.comment,
                condition: item.condition,
                size: item.size,
                price: item.price,
                arrival_date: item.arrival_date,
                charge: item.charge,
                location: item.location,
                delivery: item.delivery,
                category_id: category.id,
                item_images: item_images_11
              }
            }
          }.not_to change(Item, :count)
        end

        it 'renders new' do
          subject
          expect(response).to render_template :new
        end
      end

    end
  end
    
  describe '#show' do

    let(:created_item1) { create(:item, seller: user, category: category) }
    let(:created_item2) { create(:item, seller: user, category: category) }
    let(:created_item3) { create(:item, seller: user, category: category) }
    let(:created_item4) { create(:item, seller: user, category: category) }
    let(:created_item5) { create(:item, seller: user, category: category) }
    let(:created_item6) { create(:item, seller: user, category: category) }
    let(:created_item7) { create(:item, seller: another_user, category: category) }
    let(:created_item8) { create(:item, seller: user, category: another_category) }

    before do
      get :show,
      params: { id: created_item1.id }
    end

    it 'assigns @item' do
      expect(assigns(:item)).to eq created_item1
    end

    it 'assigns @seller_items' do
      expect(assigns(:seller_items)).to eq [created_item8, created_item6, created_item5, created_item4, created_item3, created_item2]
    end

    it 'assigns @category_items' do
      expect(assigns(:category_items)).to eq [created_item7, created_item6, created_item5, created_item4, created_item3, created_item2]
    end

    it 'renders show' do
      expect(response).to render_template :show
    end

  end

  describe '#destroy' do
    
    context 'log in' do

      before do
        login user
      end

      context 'can delete' do
        
        it 'delete item' do
          delete_item = create(:item, seller: user)
          expect{
            delete :destroy,
            params: { id: delete_item.id }
          }.to change(Item, :count).by(-1)
        end

        it 'delete item images' do
          delete_item = create(:item, seller: user)
          3.times do
            create(:item_image, item: delete_item)
          end
          expect{
            delete :destroy,
            params: { id: delete_item.id }
          }.to change(ItemImage, :count).by(-3)
        end

        it 'redirect to users#show' do
          delete_item = create(:item, seller: user)
          delete :destroy, params: { id: delete_item.id }
          expect(response).to redirect_to redirect_to(user_path(user))
        end
      end

      context 'can not delete' do
        
        it 'does not delete item' do
          delete_item = create(:item, seller: another_user)
          expect{
            delete :destroy,
            params: { id: delete_item }
          }.not_to change(Item, :count)
        end
        
        it 'does not delete item images' do
          delete_item = create(:item, seller: another_user)
          3.times do
            create(:item_image, item: delete_item)
          end
          expect{
            delete :destroy,
            params: { id: delete_item.id }
          }.not_to change(ItemImage, :count)
        end

        it 'redirect to show' do
          delete_item = create(:item, seller: another_user)
          delete :destroy, params: { id: delete_item.id }
          expect(response).to redirect_to redirect_to(item_path(delete_item))
        end

      end

    end
  end

  describe '#update' do

    context 'log in' do

      before do
        login user
      end

      context 'can update' do

        subject {
          patch :update,
          params: {
            id: created_item.id,
            seller_id: user.id,
            item: {
              name: "updated_item_name",
              item_images: item_images_2
            }
          }
        }

        it 'update item' do
          subject
          expect(created_item.reload.name).to eq "updated_item_name"
        end

        it 'update item images' do
          expect{ subject }.to change(ItemImage, :count).by(2)
        end

        it 'redirects to show' do
          subject
          expect(response).to redirect_to(item_path(created_item))
        end

      end

      context 'can not update' do
        subject {
          patch :update,
          params: {
            id: created_item.id,
            seller_id: user.id,
            item: {
              name: nil
            }
          }
        }

        it 'does not update item' do
          subject
          expect(created_item.reload.name).to eq "ニットワンピース"
        end

        it 'does not count up with more than ten item_images' do
          expect{
            post :create,
            params: {
              seller_id: user.id,
              item: {
                name: item.name,
                comment: item.comment,
                condition: item.condition,
                size: item.size,
                price: item.price,
                arrival_date: item.arrival_date,
                charge: item.charge,
                location: item.location,
                delivery: item.delivery,
                category_id: category.id,
                item_images: item_images_11
              }
            }
          }.not_to change(Item, :count)
        end

        it 'render to show' do
          subject
          expect(response).to render_template :edit
        end

        it 'render to show without item images' do
          no_update_item = create(:item, seller: user)
          patch :update,
          params: {
            id: no_update_item.id,
            seller_id: user.id,
            item: {
              name: "updated_item_name",
            }
          }
          expect(response).to render_template :edit
        end

        it 'render to show with more than 10 item images' do
          no_update_item = create(:item, seller: user)
          patch :update,
          params: {
            id: no_update_item.id,
            seller_id: user.id,
            item: {
              name: "updated_item_name",
              item_images: item_images_11
            }
          }
          expect(response).to render_template :edit
        end
        
      end
    end

  end

  describe '#update_status' do

    context 'log in' do
      before do
        login user
      end

      context 'can update' do

        subject {
          patch :update_status,
          params: { id: created_item.id }
        }

        it 'update item status' do
          subject
          expect(created_item.reload.status).to eq "公開停止中"
        end

        it 'redirects to show' do
          subject
          expect(response).to redirect_to(item_path(created_item))
        end

      end

      context 'can not update' do

        subject {
          patch :update_status,
          params: { id: another_seller_item.id }
        }

        it 'does not update item status' do
          subject
          expect(another_seller_item.reload.status).to eq "出品中"
        end

      end

    end

  end

  describe '#destroy_image' do

    context 'log in' do
      before do
        login user
      end

      context 'can delete' do

        it 'delete item image' do
          delete_item_image = create(:item_image, item: created_item)
          expect{
            delete :destroy_image,
            params: { id: delete_item_image.id }
          }.to change(ItemImage, :count).by(-1)
        end
  
        it 'render to edit' do
          delete_item_image = create(:item_image, item: created_item)
          delete :destroy_image, params: { id: delete_item_image.id }
          expect(response).to render_template :edit
        end

      end

      context 'can not delete' do

        it 'does not delete item image' do
          delete_item_image = create(:item_image, item: another_seller_item)
          expect{
            delete :destroy_image,
            params: { id: delete_item_image.id }
          }.not_to change(ItemImage, :count)
        end

      end

    end
  end

  describe '#pay' do

    context 'log in' do
      before do
        login user
      end

      context 'can buy' do

        it 'change item status' do
          create(:card, user: user)
          seller = create(:user, email: "seller@gmail.com")
          seller_item = create(:item, seller: seller, category: category)
          create(:sale, user: seller)
          post :pay, params: { id: seller_item.id }
          expect(seller_item.reload.status).to eq "売却済み"
        end

        it 'update seller sales' do
          create(:card, user: user)
          seller = create(:user, email: "seller@gmail.com")
          seller_item = create(:item, seller: seller, category: category)
          seller_sale = create(:sale, user: seller)
          post :pay, params: { id: seller_item.id }
          expect(seller_sale.reload.sales).to eq seller_item.price
        end

        it 'redirects to root' do
          create(:card, user: user)
          seller = create(:user, email: "seller@gmail.com")
          seller_item = create(:item, seller: seller, category: category)
          seller_sale = create(:sale, user: seller)
          post :pay, params: { id: seller_item.id }
          expect(response).to redirect_to(root_path)
        end

      end

      context 'can not buy by seller' do

        it 'does not update item status' do
          create(:card, user: user)
          create(:address, user_id: user.id)
          user_item = create(:item, seller: user, category: category)
          create(:sale, user: user)
          post :pay, params: { id: user_item.id }
          expect(user_item.reload.status).to eq "出品中"
        end
        
        it 'does not update seller sales' do
          create(:card, user: user)
          create(:address, user_id: user.id)
          user_item = create(:item, seller: user, category: category)
          user_sale = create(:sale, user: user)
          post :pay, params: { id: user_item.id }
          expect(user_sale.reload.sales).to eq 0
        end

        it 'render to buy' do
          create(:card, user: user)
          create(:address, user_id: user.id)
          user_item = create(:item, seller: user, category: category)
          create(:sale, user: user)
          post :pay, params: { id: user_item.id }
          expect(response).to render_template :buy
        end

      end

      context 'can not buy sold out item' do
        
        it 'does not update seller sales' do
          create(:card, user: user)
          create(:address, user_id: user.id)
          seller = create(:user, email: "seller@gmail.com")
          seller_item = create(:item, seller: seller, category: category, status: "売却済み")
          seller_sale = create(:sale, user: seller)
          post :pay, params: { id: seller_item.id }
          expect(seller_sale.reload.sales).to eq 0
        end

        it 'render to buy' do
          create(:card, user: user)
          create(:address, user_id: user.id)
          seller = create(:user, email: "seller@gmail.com")
          seller_item = create(:item, seller: seller, category: category, status: "売却済み")
          seller_sale = create(:sale, user: seller)
          pre_sales = seller_sale.sales
          post :pay, params: { id: seller_item.id }
          expect(response).to render_template :buy
        end

      end

    end
  end

end