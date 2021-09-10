class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postcode, :city, :prefecture_id, :block, :building, :tel_number, :token

  with_options presence: true do
    validates :postcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'は（-)を含めてください' }
    validates :prefecture_id, numericality: { other_than: 1, message: "は（--）以外を選んでください" }
    validates :city, :block
    validates :user_id, :item_id
    validates :token
    validates :tel_number, format: { with: /\A\d{10}$|^\d{11}\z/ }
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postcode: postcode, city: city, prefecture_id: prefecture_id, block: block, building: building,
                   tel_number: tel_number, order_id: order.id)
  end
end
