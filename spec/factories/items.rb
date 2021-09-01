FactoryBot.define do
  factory :item do

    item_name      { Faker::Name.name}
    explanation    { Faker::Lorem.sentence}
    price          { Faker::Number.between(from: 300, to: 999999 )}
    category       { Category.find_by_id 2 }
    prefecture     { Prefecture.find_by_id 2}
    status         { Status.find_by_id 2}
    shipping_burden{ ShippingBurden.find_by_id 2}
    days_ship      { DaysShip.find_by_id 2}
    user

    after(:build) do |message|
      message.image.attach(io: File.open('public/test_image.png'), filename: 'test_image.png')
    end
  end
end
