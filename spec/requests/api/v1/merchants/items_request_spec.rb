require 'rails_helper'

describe 'Merchant Items API' do
  it 'can return the items for a specific merchant' do
    merchant = create(:merchant)
    3.times do
      create(:item, merchant: merchant)
    end

    merchant_2 = create(:merchant)
    3.times do
      create(:item, merchant: merchant_2)
    end

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expecct(items[:data]).first[:type].to eq('item')
    expect(items[:data]).length.to eq(3)
  end
end
