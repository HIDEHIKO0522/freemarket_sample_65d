require 'rails_helper'

describe Card do
  describe '#create' do
    # numberが空では登録できないこと
    it "is invalid without a number" do
      card = build(:card, number: "")
      card.valid?
      expect(card.errors[:number]).to include("can't be blank")
    end
    # security_codeが空では登録できないこと
    it "is invalid without a security_code" do
      card = build(:card, security_code: "")
      card.valid?
      expect(card.errors[:security_code]).to include("can't be blank")
    end
    # user_idが空では登録できないこと
    it "is invalid without a user_id" do
      card = build(:card, user_id: "")
      card.valid?
      expect(card.errors[:user_id]).to include("can't be blank")
    end
    # expiration_monthが空では登録できないこと
    it "is invalid without a expiration_month" do
      card = build(:card, expiration_month: "")
      card.valid?
      expect(card.errors[:expiration_month]).to include("can't be blank")
    end
    # expiration_yearが空では登録できないこと
    it "is invalid without a expiration_year " do
      card = build(:card, expiration_year: "")
      card.valid?
      expect(card.errors[:expiration_year]).to include("can't be blank")
    end

  end
end