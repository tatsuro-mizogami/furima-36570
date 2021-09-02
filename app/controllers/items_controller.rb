class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @item = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render new_item_path
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :explanation, :text, :price, :category_id, :status_id, :shipping_burden_id,
                                 :prefecture_id, :days_ship_id, :image).merge(user_id: current_user.id)
  end
end
