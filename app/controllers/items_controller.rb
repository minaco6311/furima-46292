class ItemsController < ApplicationController
  
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :move_to_index, only: [:edit, :update]

  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @item = Item.new(item_params.merge(user_id: current_user.id))

    if @item.save
      redirect_to root_path   # 保存できたらトップへ
    else
      render :new, status: :unprocessable_entity  # 失敗ならnewへ戻す
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :item_name, :item_detail, :price, 
      :item_category_id, :item_condition_id,
      :shipping_cost_id, :shipping_area_id, :delivery_time_id
    )
  end

  def move_to_index
    @item = Item.find(params[:id])
    redirect_to root_path unless current_user.id == @item.user_id
  end

end
