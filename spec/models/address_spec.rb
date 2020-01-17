require 'rails_helper'

describe Address do
  describe '#create' do

    it "郵便番号が空では登録できないこと" do
      address = build(:address, postal_code: "")
      address.valid?
      expect(address.errors[:postal_code]).to include("can't be blank")
    end

    it "県名が空では登録できないこと" do
      address = build(:address, prefectures: "")
      address.valid?
      expect(address.errors[:prefectures]).to include("can't be blank")
    end

    it "市が空では登録できないこと" do
      address = build(:address, city: "")
      address.valid?
      expect(address.errors[:city]).to include("can't be blank")
    end

    it "住所番号が空では登録できないこと" do
      address = build(:address, house_number: "")
      address.valid?
      expect(address.errors[:house_number]).to include("can't be blank")
    end
  end
end