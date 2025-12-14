class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path # 保存できたらトップへ
    else
      render :new, status: :unprocessable_entity # 失敗ならnewへ戻す
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy if item.user_id == current_user.id
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(
      :item_name, :item_detail, :price, :image,
      :item_category_id, :item_condition_id,
      :shipping_cost_id, :shipping_area_id, :delivery_time_id
    ).merge(user_id: current_user.id)
  end
end
