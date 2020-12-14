require 'rails_helper'

describe 'Item Merchants API' do
  it 'can return the merchant for a specific item' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)

    item = create(:item, merchant: merchant_1)

    get "/api/v1/items/#{item.id}/merchants"

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data]).to have_key(:attributes)
    expect(merchant[:data]).to have_key(:type)
    expect(merchant[:data][:type]).to eq('merchant')
    expect(merchant[:data][:attributes][:name]).to eq(merchant_1.name)
  end
end
