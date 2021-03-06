class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :prefecture
  belongs_to :days_ship
  belongs_to :shipping_burden
  belongs_to :status
  belongs_to :user
  has_one :order, foreign_key: :item_id, dependent: :destroy

  has_one_attached :image

  validates :item_name, :explanation, :price, :image, presence: true

  validates :category_id, :days_ship_id, :prefecture_id, :shipping_burden_id, :status_id,
            numericality: { other_than: 1, message: "は（--）以外を選んでください" }

  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, only_integer: true }
end
