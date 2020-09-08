require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('public/images/star.png')
  end

  describe '商品出品' do
    context '商品出品がうまくいくとき' do
      it "image、name、description、category、status、shipping_fee_burden、shipping_prefecture、shipping_days、priceが正しく入力されれば出品できること" do
        expect(@item).to be_valid
      end
    end

    context '商品出品がうまくいかないとき' do
      it "imageが空だと登録できないこと" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it "nameが空だと登録できないこと" do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it "descriptionが空だと登録できないこと" do
        @item.description = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it "categoryが空だと登録できないこと" do
        @item.category = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it "statusが空だと登録できないこと" do
        @item.status = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end
      it "shipping_fee_burdenが空だと登録できないこと" do
        @item.shipping_fee_burden = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee burden can't be blank")
      end
      it "shipping_prefectureが空だと登録できないこと" do
        @item.shipping_prefecture = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping prefecture can't be blank")
      end
      it "shipping_daysが空だと登録できないこと" do
        @item.shipping_days = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping days can't be blank")
      end
      it "priceが空だと登録できないこと" do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it "priceが半角数字でなければ登録できないこと" do
        @item.price = '３０００'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid. Input a number from 300 to 9999999.")
      end
      it "priceが300円未満では保存できないこと" do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid. Input a number from 300 to 9999999.")
      end
      it "priceが10,000,000円以上だと保存できないこと" do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid. Input a number from 300 to 9999999.")
      end

    end
  end
end
