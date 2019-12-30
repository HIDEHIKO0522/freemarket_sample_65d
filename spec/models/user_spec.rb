require 'rails_helper'

describe User do
  describe '#create' do
    # nickname, email, password, password_confirmation, family_name, first_name, family_name_kana, first_name_kana, birthyear, birthmonth, birthdayが存在すれば登録できること
    it "is valid with a nickname, email, password, password_confirmation, family_name, first_name, family_name_kana, first_name_kana, birthyear, birthmonth, birthday," do
      user = build(:user)
      expect(user).to be_valid
    end
    # nicknameが空では登録できないこと
    it "is invalid without a nickname" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end
    # emailが空では登録できないこと
    it "is invalid without a email" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end
    # passwordが空では登録できないこと
    it "is invalid without a password" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    # password,password_confirmationが6文字以上であれば登録できること
    it "is valid with a password that has more than 6 characters " do
      user = build(:user, password: "000000", password_confirmation: "000000")
      user.valid?
      expect(user).to be_valid
    end

    # password,password_confirmationが5文字以下であれば登録できないこと
    it "is invalid with a password that has less than 5 characters " do
      user = build(:user, password: "00000", password_confirmation: "00000")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end
    # password_confirmationが空では登録できないこと
    it "is invalid without a password_confirmation" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("can't be blank")
    end
    #passwordが存在してもpassword_confirmationが空では登録できないこと
    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    # family_nameが空では登録できないこと
    it "is invalid without a family_name" do
      user = build(:user, family_name: "")
      user.valid?
      expect(user.errors[:family_name]).to include("can't be blank")
    end
    # first_nameが空では登録できないこと
    it "is invalid without a first_name" do
      user = build(:user, first_name: "")
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end
    # family_name_kanaが空では登録できないこと
    it "is invalid without a family_name_kana" do
      user = build(:user, family_name_kana: "")
      user.valid?
      expect(user.errors[:family_name_kana]).to include("can't be blank")
    end
    # first_name_kanaが空では登録できないこと
    it "is invalid without a first_name_kana" do
      user = build(:user, first_name_kana: "")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("can't be blank")
    end
    # birthyearが空では登録できないこと
    it "is invalid without a birthyear" do
      user = build(:user, birthyear: "")
      user.valid?
      expect(user.errors[:birthyear]).to include("can't be blank")
    end
    # birthmonthが空では登録できないこと
    it "is invalid without a birthmonth" do
      user = build(:user, birthmonth: "")
      user.valid?
      expect(user.errors[:birthmonth]).to include("can't be blank")
    end
    # birthdayが空では登録できないこと
    it "is invalid without a birthday" do
      user = build(:user, birthday: "")
      user.valid?
      expect(user.errors[:birthday]).to include("can't be blank")
    end
    # telが空では登録できないこと
    it "is invalid without a tel" do
      user = build(:user, tel: "")
      user.valid?
      expect(user.errors[:tel]).to include("can't be blank")
    end
    #passwordが存在してもpassword_confirmationが空では登録できないこと
    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
  end

end