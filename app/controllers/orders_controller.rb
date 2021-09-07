class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_root

  def index
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new
  end
  
  def new
    @order_address = OrderAddress.new
  end
  
  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      # binding.pry
      Payjp.api_key = "sk_test_7f339bd6bfb0b33ee99d848e"
      Payjp::Charge.create(
        amount: @item.price,
        card: order_params[:token],
        currency: 'jpy'
      )
       @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end
  
  private
  
  def order_params
    params.require(:order_address).permit(:postcode, :prefecture_id, :city, :block, :building, :tel_number, :order_id).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end
  
  def move_to_root
    @item = Item.find(params[:item_id])
    if current_user == @item.user
      redirect_to root_path
    end
  end
end