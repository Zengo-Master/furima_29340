class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :show]
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
    item = Item.find(params[:id])
    item.destroy
    return redirect_to root_path
  end

  def edit
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    return redirect_to item_path(item.id)
  end

  def show
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category, :status, :shipping_fee_burden, :shipping_prefecture, :shipping_days, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index # 未ログインでの先ページアクセスを弾く
    unless user_signed_in?
      redirect_to action: :index
    end
  end

end
