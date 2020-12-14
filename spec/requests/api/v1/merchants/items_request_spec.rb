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
    expect(response.content_type).to eq("application/json")

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].length).to eq(3)
    expect(items[:data].first).to have_key(:id)
    expect(items[:data].first).to have_key(:attributes)
    expect(items[:data].first).to have_key(:type)
    expect(items[:data].first[:type]).to eq('item')    
  end
end
