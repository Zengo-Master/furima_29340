class PurchasesController < ApplicationController
  def index
  end

  def create
    Purchase.create(purchase_params)
  end

private

  def purchase_params
    params.require(:purchase).permit(user_id: current.user_id, item_id: params[:item_id])
  end
end