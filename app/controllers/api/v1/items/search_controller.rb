class Api::V1::Items::SearchController < ApplicationController
  def show
    attribute = query_params.keys.first
    query = query_params[attribute]
    render json: ItemSerializer.new(Item.find_item(attribute, query))
  end

  private

  def query_params
    params.permit(:name, :created_at, :updated_at)
  end
end
