require 'rails_helper'
describe Item do
  describe '#create' do
    context 'can save' do
      it "is valid with a name, comment, category_id, condition, size, price, arrival_date, charge, location, delivery" do
        expect(build(:item)).to be_valid
      end
    end

    context 'can not save' do
      it "is invalid without a name" do
        item = build(:item, name: nil)
        item.valid?
        expect(item.errors[:name]).to include("can't be blank")
      end

      it "is invalid without a comment" do
        item = build(:item, comment: nil)
        item.valid?
        expect(item.errors[:comment]).to include("can't be blank")
      end
  
      it "is invalid without a category_id" do
        item = build(:item, category_id: nil)
        item.valid?
        expect(item.errors[:category]).to include("must exist")
      end

      it "is invalid without a condition" do
        item = build(:item, condition: nil)
        item.valid?
        expect(item.errors[:condition]).to include("can't be blank")
      end

      it "is invalid without a seller_id" do
        item = build(:item, seller_id: nil)
        item.valid?
        expect(item.errors[:seller]).to include("must exist")
      end

      it "is invalid without a size" do
        item = build(:item, size: nil)
        item.valid?
        expect(item.errors[:size]).to include("can't be blank")
      end

      it "is invalid under 300 price" do
        item = build(:item, price: 299)
        item.valid?
        expect(item.errors[:price]).to include("must be greater than or equal to 300")
      end
  
      it "is invalid without an arrival_date" do
        item = build(:item, arrival_date: nil)
        item.valid?
        expect(item.errors[:arrival_date]).to include("can't be blank")
      end

      it "is invalid without a charge" do
        item = build(:item, charge: nil)
        item.valid?
        expect(item.errors[:charge]).to include("can't be blank")
      end

      it "is invalid without a location" do
        item = build(:item, location: nil)
        item.valid?
        expect(item.errors[:location]).to include("can't be blank")
      end

      it "is invalid without a delivery" do
        item = build(:item, delivery: nil)
        item.valid?
        expect(item.errors[:delivery]).to include("can't be blank")
      end
    end
  end
end