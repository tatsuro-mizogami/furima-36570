class ItemsController < ApplicationController
  def index
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

  private

  def item_params
    params.require(:item).permit(:item_name, :explanation, :text, :price, :category_id, :status_id, :shipping_burden_id,
                                 :prefecture_id, :days_ship_id, :image).merge(user_id: current_user.id)
  end
end
