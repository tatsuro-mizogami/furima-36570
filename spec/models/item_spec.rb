require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.build(:user)
    @item = FactoryBot.build(:item)
  end

  describe 'アイテムの出品' do
    context 'アイテムが出品できる場合' do
      it '全ての項目が存在すれば出品できる' do
        expect(@item).to be_valid
      end
      it '価格が半角数字であれば出品できる' do
        @item.price = '1000'
        expect(@item).to be_valid
      end
      it '価格が300以上であれば出品できる' do
        @item.price = '300'
        expect(@item).to be_valid
      end
      it '価格が9999999以下であれば出品できる' do
        @item.price = '9999999'
        expect(@item).to be_valid
      end
    end
    context 'アイテムが出品できない場合' do
      it '商品名が空では出品できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it '商品の説明が空では出品できない' do
        @item.explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end
      it 'カテゴリーが--では出品できない' do
        @item.category = Category.find_by_id 1
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーは（--）以外を選んでください")
      end
      it '商品の状態が--では出品できない' do
        @item.status = Status.find_by_id 1
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態は（--）以外を選んでください")
      end
      it '配送料の負担が--では出品できない' do
        @item.shipping_burden = ShippingBurden.find_by_id 1
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担は（--）以外を選んでください")
      end
      it '発送元の地域が--では出品できない' do
        @item.prefecture = Prefecture.find_by_id 1
        @item.valid?
        expect(@item.errors.full_messages).to include("配送元の地域は（--）以外を選んでください")
      end
      it '発送までの日数が--では出品できない' do
        @item.days_ship = DaysShip.find_by_id 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数は（--）以外を選んでください")
      end
      it '価格が空では出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格を入力してください", "販売価格は数値で入力してください")
      end
      it '商品画像が空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end
      it '価格が全角では出品できない' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は数値で入力してください")
      end
      it '価格が299以下では出品できない' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は300以上の値にしてください")
      end
      it '価格が10000000以上では出品できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は9999999以下の値にしてください")
      end
      it 'ユーザーが紐付いていなければ出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end
