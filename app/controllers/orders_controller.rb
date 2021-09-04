class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index
  def index
    # binding.pry
    @item = Item.find(params[:item_id])
  end
  
end
