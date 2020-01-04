require 'rails_helper'

describe ItemsController do

  describe '#create' do
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

end