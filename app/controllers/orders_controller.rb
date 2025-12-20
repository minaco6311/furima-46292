class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item

  def index
    # 自分が出品した商品は購入できない
    return redirect_to root_path if current_user.id == @item.user_id

    # すでに売れている商品は購入できない
    return redirect_to root_path if @item.order.present?

    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)

    if @order_address.valid?
      begin
        Payjp.api_key = ENV["PAYJP_SECRET_KEY"]

        Payjp::Charge.create(
          amount: @item.price,
          card: @order_address.token,
          currency: "jpy"
        )

        @order_address.save
        redirect_to root_path
      rescue Payjp::PayjpError => e
        Rails.logger.error "PAYJP ERROR: #{e.message}"
        flash.now[:alert] = "カード情報を確認してください"
        render :index, status: :unprocessable_entity
      end
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_address).permit(
      :postal_code,
      :shipping_area_id,
      :city,
      :addresses,
      :building,
      :phone_number
    ).merge(
      user_id: current_user.id,
      item_id: params[:item_id],
      token: params[:token]
    )
  end
end
