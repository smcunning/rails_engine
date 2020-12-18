class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: MerchantFacade.most_revenue(params[:quantity])
  end

  def show
    render json: RevenueFacade.merchant_revenue(params[:id])
  end
end
