require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @user = FactoryBot.create(:user)
    @order_address = FactoryBot.build(:order_address, user_id: @user, item_id: @item)
  end

  describe '配送先の保存' do
    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_address).to be_valid
      end
      it '建物名は空でも保存できること' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '郵便番号が空だと保存できないこと' do
        @order_address.postcode = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("郵便番号を入力してください", "郵便番号は（-)を含めてください")
      end
      it '郵便番号が半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_address.postcode = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("郵便番号は（-)を含めてください")
      end
      it '都道府県を選択していないと保存できないこと' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("都道府県は（--）以外を選んでください")
      end
      it '市区町村が空だと保存できないこと' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("市区町村を入力してください")
      end
      it '番地が空だと保存できないこと' do
        @order_address.block = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("番地を入力してください")
      end
      it '電話番号が空ではでは保存できないこと' do
        @order_address.tel_number = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号を入力してください", "電話番号は不正な値です")
      end
      it '電話番号が9桁以下では保存できないこと' do
        @order_address.tel_number = 112_233_445
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号は不正な値です")
      end
      it '電話番号が12桁以上では保存できないこと' do
        @order_address.tel_number = 112233445566
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号は不正な値です")
      end
      it '電話番号が全角数値では保存できないこと' do
        @order_address.tel_number = '１１２２３３４４５５'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号は不正な値です")
      end
      it 'tokenが空では保存できないこと' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("クレジット情報を入力してください")
      end
      it 'ユーザーが紐付いていなければ購入できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Userを入力してください")
      end
      it 'itemが紐付いていなければ購入できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Itemを入力してください")
      end
    end
  end
end
