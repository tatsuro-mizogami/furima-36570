class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postcode, :city, :prefecture_id, :block, :building, :tel_number, :order_id, :token

  with_options presence: true do
    validates :postcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}
    validates :city, :block
    validates :user_id
    validates :token
    validates :tel_number, format: { with: /\A\d{10}$|^\d{11}\z/ }
  end

  def save
    # binding.pry
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postcode: postcode, city: city, prefecture_id: prefecture_id, block: block, building: building, tel_number: tel_number, order_id: order.id)
  end
end