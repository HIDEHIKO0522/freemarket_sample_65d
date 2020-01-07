require 'rails_helper'
describe Category do
  describe '#create' do
    context 'can save' do
      it "is valid with a name" do
        expect(build(:category)).to be_valid
      end
    end

    context 'can not save' do
      it "is invalid without a name" do
        category = build(:category, name: nil)
        category.valid?
        expect(category.errors[:name]).to include("can't be blank")
      end
    end
  end
end