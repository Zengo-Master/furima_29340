class ShippingAddressesController < ApplicationController
  def create
    Shipping_address.create(purchase_params)
  end

private

  def purchase_params
    params.require(:shipping_address).permit(:buyer_postal_code, :buyer_prefecture, :buyer_city, :buyer_home_number, :buyer_building_name, :buyer_phone_number).merge(purchase_id: params[:purchase_id])
  end

end
