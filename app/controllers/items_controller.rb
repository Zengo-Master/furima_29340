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
      return redirect_to root_path # トップページへ
    else
      render "new"
    end
  end

  def tax
    # item_price = Item.find(params[:price]) # 入力された価格のid

    # tax_price = item_price / 10
    # profit = item_price - tax_price

    # render json: { tax_price: tax_price }
    # render json: { profit: profit }
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    return redirect_to root_path
  end

  def edit
  end

  def update
    item = Tweet.find(params[:id])
    item.update(item_params)
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
