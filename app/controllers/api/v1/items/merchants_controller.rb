class Api::V1::Items::MerchantsController < ApplicationController
  def index
    render json: MerchantFacade.find_by_item(params[:item_id])
  end
end
