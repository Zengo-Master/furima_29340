class ReviewsController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    Review.create(review_params)
    redirect_to item_path(@item.id)
  end

  private

  def review_params
    params.require(:review).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
