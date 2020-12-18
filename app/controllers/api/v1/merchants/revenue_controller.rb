class Api::V1::Merchants::RevenueController < ApplicationController
  def revenue
    render json: RevenueFacade.merchant_revenue(params[:id])
  end

  def most_revenue
    render json: MerchantFacade.most_revenue(params[:quantity])
  end
end
