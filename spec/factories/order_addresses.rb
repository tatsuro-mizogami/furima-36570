FactoryBot.define do
  factory :order_address do
    postcode { '123-4567' }
    prefecture_id { 2 }
    city { '東京都' }
    tel_number { '09011112222' }
    building { '東京ハイツ' }
    block { '歯科' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
