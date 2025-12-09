FactoryBot.define do
  factory :item do
    item_name        { 'テスト商品' }
    item_detail      { 'テスト商品の説明です' }
    item_category_id { 2 }  # 1は'---'なので2以上で設定
    item_condition_id { 2 }
    shipping_cost_id  { 2 }
    shipping_area_id  { 2 }
    delivery_time_id  { 2 }
    price            { 1000 } # 正常値

    association :user

    # 画像を自動添付
    after(:build) do |item|
      item.image.attach(
        io: File.open('public/images/test_image.png'),
        filename: 'test_image.png'
      )
    end
  end
end
