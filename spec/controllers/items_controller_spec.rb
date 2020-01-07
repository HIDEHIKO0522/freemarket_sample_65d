require 'rails_helper'

describe ItemsController do

  let(:category) { create(:category) }
  let(:user) { create(:user) }
  let(:item) { build(:item) }
  let(:item_images) { build_list(:item_image, 2) }
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
        item_images: item_images
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
        item_images: item_images
      }
    }
  }

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

        it 'renders new' do
          subject
          expect(response).to render_template :new
        end
      end

    end
  end

  describe '#show' do

    let(:another_user) { create(:user, email: "lll@gmail.com") }
    let(:another_category) { create(:category, name: "メンズ") }
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

end