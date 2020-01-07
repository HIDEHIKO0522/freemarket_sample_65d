require 'rails_helper'
describe ItemImage do
  describe '#create' do
    context 'can save' do
      it "is valid with a item_id, image" do
        expect(build(:item_image)).to be_valid
      end
    end

    context 'can not save' do
      it "is invalid without a item_id" do
        item_image = build(:item_image, item_id: nil)
        item_image.valid?
        expect(item_image.errors[:item]).to include("must exist")
      end

      it "is invalid without a image" do
        item_image = build(:item_image, image: nil)
        item_image.valid?
        expect(item_image.errors[:image]).to include("can't be blank")
      end
    end
  end
end