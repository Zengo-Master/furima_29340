require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  before do
    @shipping_address = FactoryBot.build(:shipping_address)
  end

  describe '商品購入' do
    context '商品購入がうまくいくとき' do
      it "buyer_postal_code、buyer_prefecture_id、buyer_city、buyer_home_number、buyer_building_name、buyer_phone_numberが正しく入力されれば購入できること" do
        expect(@shipping_address).to be_valid
      end
      it "buyer_building_nameは空でも、他が正しく入力されれば購入できること" do
        @shipping_address.buyer_building_name = ""
        expect(@shipping_address).to be_valid
      end
    end

    context '商品購入がうまくいかないとき' do
      it "buyer_postal_codeが空だと登録できないこと" do
        @shipping_address.buyer_postal_code = ""
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Buyer_postal_code can't be blank")
      end
      it "buyer_postal_codeのハイフンが抜けていると登録できないこと" do
        @shipping_address.buyer_postal_code = "1234567"
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Buyer_postal_code is invalid. Include hyphen(-)")
      end
      it "buyer_prefecture_idが空だと登録できないこと" do
        @shipping_address.buyer_prefecture_id = 0
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Buyer_prefecture can't be ---")
      end
      it "buyer_cityが空だと登録できないこと" do
        @shipping_address.buyer_city = ""
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Buyer_city can't be blank")
      end
      it "buyer_home_numberが空だと登録できないこと" do
        @shipping_address.buyer_home_number = ""
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Buyer_home_number can't be blank")
      end
      it "buyer_phone_numberが空だと登録できないこと" do
        @shipping_address.buyer_phone_number = ""
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Buyer_phone_number can't be blank")
      end
      it "buyer_phone_numberにハイフンが含まれていると登録できないこと" do
        @shipping_address.buyer_phone_number = "090-3823-9958"
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Buyer_phone_number is invalid. Input numbers within 11 digits without a hyphen(-).")
      end

    end
  end
end
