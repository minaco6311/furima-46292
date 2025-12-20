FactoryBot.define do
  factory :order_address do
    user_id { 1 }
    item_id { 1 }
    postal_code { "123-4567" }
    shipping_area_id { 2 }
    city { "渋谷区" }
    addresses { "1-1-1" }
    building { "柳ビル" }
    phone_number { "09012345678" }
    token { "tok_abcdefghijk00000000000000000" }
  end
end
