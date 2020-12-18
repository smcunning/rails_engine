class Api::V1::RevenueController < ApplicationController
  def show
    render json: RevenueFacade.total_revenue_by_date(params[:start], params[:end])
  end
end
