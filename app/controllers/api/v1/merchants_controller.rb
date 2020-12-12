class Api::V1::MerchantsController < ApplicationController
  def index
   render json: MerchantFacade.all_merchants
  end

  def show
   render json: MerchantFacade.merchant_by_id(params[:id])
  end
end
