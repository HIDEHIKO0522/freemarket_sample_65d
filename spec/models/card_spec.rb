require 'rails_helper'

describe Card do
  describe '#create' do

    it "カード番号が空では登録できないこと" do
      card = build(:card, number: "")
      card.valid?
      expect(card.errors[:number]).to include("can't be blank")
    end

    it "セキュリティコードが空では登録できないこと" do
      card = build(:card, security_code: "")
      card.valid?
      expect(card.errors[:security_code]).to include("can't be blank")
    end

    it "有効期限（月）が空では登録できないこと" do
      card = build(:card, expiration_month: "")
      card.valid?
      expect(card.errors[:expiration_month]).to include("can't be blank")
    end

    it "有効期限（年）が空では登録できないこと " do
      card = build(:card, expiration_year: "")
      card.valid?
      expect(card.errors[:expiration_year]).to include("can't be blank")
    end

    it "トークンが空では登録できないこと " do
      card = build(:card, token: "")
      card.valid?
      expect(card.errors[:token]).to include("can't be blank")
    end

  end
end