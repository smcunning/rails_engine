class Api::V1::MerchantsController < ApplicationController
  def index
   render json: MerchantFacade.all_merchants
  end

  def show
   render json: MerchantFacade.merchant_by_id(params[:id])
  end

  def create
    render json: MerchantFacade.create_merchant(merchant_params)
  end

  def update
    render json: MerchantFacade.update_merchant(params[:id], merchant_params)
  end

  def destroy
    MerchantFacade.delete_merchant(params[:id])
  end

  private

  def merchant_params
    params.permit(:name)
  end
end
