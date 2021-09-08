class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_root
  before_action :sold_out_item
  before_action :set_item, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
  end


  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_order
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postcode, :prefecture_id, :city, :block, :building, :tel_number, :order_id).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def move_to_root
    @item = Item.find(params[:item_id])
    redirect_to root_path if current_user == @item.user
  end

  def pay_order
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def sold_out_item
    redirect_to root_path if @item.order.present?
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

end
