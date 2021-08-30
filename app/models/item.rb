class Item < ApplicationRecord
  belongs_to :user
  has_one :order
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category, :days_ship, :prefecture, :shipping_burden, :status

  validates :item_name, :explanation, :price, :image, presence: true

  validates :category_id, :days_ship_id, :prefecture_id, :shipping_burden_id, :status_id, numericality: { other_than: 1 , message: "can't be blank"}

end
