class Order < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :address, foreign_key: :order_id, dependent: :destroy
end
