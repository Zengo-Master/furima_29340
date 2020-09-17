class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :show, :destroy, :update]
  before_action :move_to_index, except: [:index, :show]

  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.valid?
      @item.save
      return redirect_to root_path
    else
      render "new"
    end
  end

  def destroy
    if item.destroy
      return redirect_to root_path
    else
      return redirect_to item_path(item.id)
    end
  end

  def edit
  end

  def update
    @item.update(item_params)
    return redirect_to item_path(item.id)
  end

  def show
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :status_id, :shipping_fee_burden_id, :shipping_prefecture_id, :shipping_days_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

end
