class Api::V1::MerchantsController < ApplicationController
 def index
   render json: MerchantFacade.all_merchants
 end
end
