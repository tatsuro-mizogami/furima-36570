class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postcode, :city, :prefecture_id, :block, :building, :tel_number

  # with_options presence: true do
  #   validates :user_id
  
  # end

  def save
    # binding.pry
    order =Order.create(user_id: user_id, item_id: item_id)
    Address.create(postcode: postcode, city: city, prefecture_id: prefecture_id, block: block, building: building, tel_number: tel_number, order_id: order.id)
  end
end