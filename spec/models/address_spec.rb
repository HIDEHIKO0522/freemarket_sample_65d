require 'rails_helper'

describe Address do
  describe '#create' do
    # postal_codeが空では登録できないこと
    it "is invalid without a postal_code" do
      address = build(:address, postal_code: "")
      address.valid?
      expect(address.errors[:postal_code]).to include("can't be blank")
    end
    # prefecturesが空では登録できないこと
    it "is invalid without a prefectures" do
      address = build(:address, prefectures: "")
      address.valid?
      expect(address.errors[:prefectures]).to include("can't be blank")
    end
    # cityが空では登録できないこと
    it "is invalid without a city" do
      address = build(:address, city: "")
      address.valid?
      expect(address.errors[:city]).to include("can't be blank")
    end
    # house_numberが空では登録できないこと
    it "is invalid without a house_number" do
      address = build(:address, house_number: "")
      address.valid?
      expect(address.errors[:house_number]).to include("can't be blank")
    end
    # typeが空では登録できないこと
    it "is invalid without a type" do
      address = build(:user, type: "")
      address.valid?
      expect(address.errors[:type]).to include("can't be blank")
    end
  end
end