FactoryBot.define do
  factory :order_address do
    postcode { '123-4567' }
    prefecture_id { 2 }
    city { '東京都' }
    tel_number { '09011112222' }
    building { '東京ハイツ' }
    block { '歯科' }
  end
end
