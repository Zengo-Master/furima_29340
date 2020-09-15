class PurchasesController < ApplicationController

  def index
    @purchase = Purchase.new
    @item = Item.find(params[:item_id])
    unless user_signed_in?
      redirect_to new_user_session_path
    end
    if user_signed_in? && current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase = PurchaseAddress.new(purchase_params)

    if @purchase.valid?
      pay_item
      @purchase.save
      return redirect_to root_path
    else
      render "index"
    end
  end

  private

  def purchase_params
    params.require(:purchase).permit(:buyer_postal_code, :buyer_prefecture_id, :buyer_city, :buyer_home_number, :buyer_building_name, :buyer_phone_number, :token).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: params[:token],
      currency:'jpy'
    )
  end

end