class Api::V1::Merchants::RevenueController < ApplicationController
  def revenue
    render json: RevenueSerializer.new(RevenueFacade.new.merchant_revenue(params[:id]))
  end

  def most_revenue
    render json: MerchantSerializer.new(Merchant.most_revenue(params[:quantity]))
  end
end
