class OrderAddress
  include ActiveModel::Model
  # attr_accessor :user_id, :order, :item_id, :postcode, :city, :prefecture_id, :block, :building, :tel_number

  with_options presence: true do
    # validates :user_id
  
  end

  def save
    # 各テーブルにデータを保存する処理を書く
  end
end