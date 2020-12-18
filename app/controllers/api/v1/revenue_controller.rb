class Api::V1::RevenueController < ApplicationController
  def show
    start = beginning_of_day(params[:start])
    stop = end_of_day(params[:end])
    total_revenue = RevenueFacade.total_revenue_by_date(start, stop)
    render json: RevenueSerializer.new(total_revenue)
  end

  private

  def beginning_of_day(date)
    date + ' 00:00:00'
  end

  def end_of_day(date)
    date + ' 23:59:59'
  end
end
