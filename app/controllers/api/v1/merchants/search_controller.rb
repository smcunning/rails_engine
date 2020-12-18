class Api::V1::Merchants::SearchController < ApplicationController
  def index
    attribute = query_params.keys.first
    query = query_params[attribute]
    render json: MerchantFacade.find_all_merchants(attribute, query)
  end

  def show
    attribute = query_params.keys.first
    query = query_params[attribute]
    render json: MerchantFacade.find_merchant(attribute, query)
  end

  private

  def query_params
    params.permit(:name, :created_at, :updated_at)
  end
end
