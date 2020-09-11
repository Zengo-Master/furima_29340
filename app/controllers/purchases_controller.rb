class PurchasesController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    
    unless user_signed_in?
      return redirect_to root_path
    end
  end

  def create
    @purchase = Purchase.new(purchase_params[:item_id.price])
    if @purchase.valid?
      pay_item
      @purchase.save
      return redirect_to root_path # 保存できたら元の購入画面へ
    else
      render 'index' # 元の購入画面からやり直し
    end
  end

private

  def purchase_params
    # params.require(:purchase).permit(user_id: current.user_id, item_id: params[:item_id], :token)
    params.require(:shipping_address).permit(:buyer_postal_code, :buyer_prefecture, :buyer_city, :buyer_home_number, :buyer_building_name, :buyer_phone_number).merge(purchase_id: params[:purchase_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # PAY.JPテスト秘密鍵（コードに直接記述しない）
    # 支払情報を生成
    Payjp::Charge.create(
      amount: price_params[:item_price],  # 商品の値段
      card: params[:token],    # カードトークン
      currency:'jpy'                 # 通貨の種類(日本円)
    )
  end

end