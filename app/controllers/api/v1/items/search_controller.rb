class Api::V1::Items::SearchController < ApplicationController
  def index
    attribute = query_params.keys.first
    query = query_params[attribute]
    render json: ItemSerializer.new(Item.find_all_items(attribute, query))
  end

  def show
    attribute = query_params.keys.first
    query = query_params[attribute]
    render json: ItemSerializer.new(Item.find_item(attribute, query))
  end

  private

  def query_params
    params.permit(:name, :unit_price, :description, :created_at, :updated_at)
  end
end
