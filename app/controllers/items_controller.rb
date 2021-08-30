class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.save
  end
  
  private
  
  def item_params
    params.require(:item).permit(:item_name, :text, :price, :category_id, :status_id, :shipping_burden_id, :prefecture_id, :days_ship_id)
    
  end
end