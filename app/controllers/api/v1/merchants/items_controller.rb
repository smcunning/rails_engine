class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    merchant = Merchant.find(params[:merchant_id])
    render json: ItemSerializer.new(merchant.items)
  end

  def most_items
    limit = params['quantity']
    merchants = Merchant.new.most_items(limit)
    render json: MerchantSerializer.new(Merchant.find([merchants.keys]))
  end
end
