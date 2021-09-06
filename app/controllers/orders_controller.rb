class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index
  def index
    @item = Item.find(params[:item_id])
  end
  
  def new
    @order_address = OrderAddress.new
  end

  def create
    # binding.pry
    @order_address = OrderAddress.new(order_params)
    @order_address.valid?
    @order_address.save
    redirect_to root_path

  end

  private

  def order_params
    # binding.pry
    params.permit(:item_id, :postcode, :prefecture_id, :city, :block, :building, :tel_number, :order_id).merge(user_id: current_user.id)
  end

end