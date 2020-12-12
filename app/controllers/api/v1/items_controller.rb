class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemFacade.all_items
  end

  def show
    render json: ItemFacade.item_by_id(params[:id])
  end

  def create
    render json: ItemFacade.create_item(item_params)
  end

  private

  def item_params
    params.require(:item).permit(:name, :unit_price, :description, :merchant_id)
  end
end
