class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemFacade.all_items
  end
end
