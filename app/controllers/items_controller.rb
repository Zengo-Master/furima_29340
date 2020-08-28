class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]

  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end
  
  def create
    Item.create(item_params)
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
  end

  def edit
  end

  def update
  end

  def show
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category, :status, :shipping_fee_burden, :shipping_prefecture, :shipping_days, :price).merge(user_id: current_user.id)
  end

  def move_to_index # 未ログインでの先ページアクセスを弾く
    unless user_signed_in?
      redirect_to action: :index
    end
  end

end
