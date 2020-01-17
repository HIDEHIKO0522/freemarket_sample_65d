require 'rails_helper'
describe Sale do
  describe '#create' do
    context 'can save' do
      it "is valid with a user_id" do
        expect(build(:sale)).to be_valid
      end
    end

    context 'can not save' do
      it "is invalid without a user_id" do
        sale = build(:sale, user: nil)
        sale.valid?
        expect(sale.errors[:user]).to include("must exist")
      end
    end
  end
end