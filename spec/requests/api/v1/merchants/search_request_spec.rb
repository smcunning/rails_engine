require 'rails_helper'

describe "Merchant Single Finder Endpoint" do
  it 'can return a single record that matches the query' do
    create(:merchant, name: "Comfy Town")

    attribute = "name"
    query = "Omf TwN"

    get "/api/v1/merchants/find?#{attribute}=#{query}"

    expect(response).to be_successful
    expect(responts.content_type).to eq("application/json")

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:type]).to eq('merchant')
    expect(merchant[:data][:attributes][:name]).to eq('Comfy Town')
  end
end
