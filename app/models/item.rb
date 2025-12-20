class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :item_category
  belongs_to :item_condition
  belongs_to :shipping_cost
  belongs_to :shipping_area
  belongs_to :delivery_time

  has_one_attached :image

  belongs_to :user

  has_one :order # 1商品は1回だけ購入される想定

  with_options presence: true do
    validates :image
    validates :item_name
    validates :item_detail
    validates :price
  end

  validates :item_category_id, :item_condition_id, :shipping_cost_id,
            :shipping_area_id, :delivery_time_id,
            numericality: { other_than: 1, message: "can't be blank" }

  validates :price, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 300,
    less_than_or_equal_to: 9_999_999
  }
end
