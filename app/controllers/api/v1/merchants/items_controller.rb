class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    render json: ItemFacade.find_by_merchant(params[:merchant_id])
  end

  def most_items
    render json: MerchantFacade.most_items(params[:quantity])
  end
end
