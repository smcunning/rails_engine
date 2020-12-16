class Api::V1::Merchants::SearchController < ApplicationController
  def show
    name_query = params[:name]
    render json: MerchantSerializer.new(Merchant.find_merchant(name_query))
  end
end
