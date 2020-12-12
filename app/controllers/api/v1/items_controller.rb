class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemFacade.all_items
  end

  def show
    render json: ItemFacade.item_by_id(params[:id])
  end
end
