require "rails_helper"

RSpec.describe OrderAddress, type: :model do
  describe "購入情報の保存" do
    before do
      @order_address = OrderAddress.new(
        user_id: 1,
        item_id: 1,
        postal_code: "123-4567",
        shipping_area_id: 2,
        city: "渋谷区",
        addresses: "1-1-1",
        building: "柳ビル",
        phone_number: "09012345678"
      )
    end

    it "全ての値が正しければ購入できる" do
      expect(@order_address).to be_valid
    end

    it "buildingが空でも購入できる" do
      @order_address.building = ""
      expect(@order_address).to be_valid
    end

    it "postal_codeにハイフンがないと購入できない" do
      @order_address.postal_code = "1234567"
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
    end

    it "phone_numberにハイフンがあると購入できない" do
      @order_address.phone_number = "090-1234-5678"
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number is invalid")
    end

    it "postal_codeが空だと購入できない" do
      @order_address.postal_code = ""
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
    end

    it "shipping_area_idが1だと購入できない" do
      @order_address.shipping_area_id = 1
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Shipping area can't be blank")
    end

    it "cityが空だと購入できない" do
      @order_address.city = ""
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("City can't be blank")
    end

    it "addressesが空だと購入できない" do
      @order_address.addresses = ""
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Addresses can't be blank")
    end

    it "phone_numberが空だと購入できない" do
      @order_address.phone_number = ""
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
    end

    it "user_idが空だと購入できない" do
      @order_address.user_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("User can't be blank")
    end

    it "item_idが空だと購入できない" do
      @order_address.item_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Item can't be blank")
    end
  end
end
