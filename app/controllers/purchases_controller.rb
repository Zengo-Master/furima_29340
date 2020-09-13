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
    @purchase = PurchaseAddress.new(purchase_params)
    @item = Item.find(params[:item_id])
    # binding.pry
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
    params.permit(:user_id, :item_id, :buyer_postal_code, :buyer_prefecture_id, :buyer_city, :buyer_home_number, :buyer_building_name, :buyer_phone_number, :purchase_id, :token)
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