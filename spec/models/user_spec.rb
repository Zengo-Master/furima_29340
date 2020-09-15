require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do # 正しい入力はFactoryBotで生成
      it "nickname、email、password、password_confirmation、family_name、first_name、family_name_kana、first_name_kana、birthdayが正しく入力されれば登録できること" do
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it "nicknameが空だと登録できないこと" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空だと登録できないこと" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "重複したemailが存在する場合に登録できないこと" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "emailに@が含まれていない場合に登録できないこと" do
        @user.email = "furima.gmail.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid", "Email does not contain '@'")
      end
      it "passwordが空だと登録できないこと" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "passwordが5文字以下だと登録できないこと" do
        @user.password = "tech1"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "passwordが半角英数字混合でなければ登録できないこと" do
        @user.password = "TechCamp"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is not mixed with half-width alphanumeric characters")
      end
      it "passwordが存在してもpassword_confirmationが空では登録できないこと" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "family_nameが空だと登録できないこと" do
        @user.family_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank", "Family name is invalid. Input in kanji.")
      end
      it "family_nameがアルファベットだと登録できないこと" do
        @user.family_name = "Yamada"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name is invalid. Input in kanji.")
      end
      it "first_nameが空だと登録できないこと" do
        @user.family_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank", "Family name is invalid. Input in kanji.")
      end
      it "first_nameがアルファベットだと登録できないこと" do
        @user.first_name = "Taro"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid. Input in hiragana or katakana or kanji.")
      end
      it "family_name_kanaが空だと登録できないこと" do
        @user.family_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank", "Family name kana is invalid. Input in katakana.")
      end
      it "family_name_kanaがひらがなだと登録できないこと" do
        @user.family_name_kana = "やまだ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana is invalid. Input in katakana.")
      end
      it "first_name_kanaが空だと登録できないこと" do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid. Input in katakana.")
      end
      it "first_name_kanaがひらがなだと登録できないこと" do
        @user.first_name_kana = "たろう"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid. Input in katakana.")
      end
      it "birthdayが空だと登録できないこと" do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end

    end
  end
end