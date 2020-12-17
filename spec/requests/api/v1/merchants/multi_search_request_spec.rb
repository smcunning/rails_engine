require 'rails_helper'

describe 'Merchant Multi-Finder Endpoint' do
  it 'can return all records that match attribute queries' do
    5.times do
      create(:merchant, name: "Sunny Bakery")
    end

    merchant = create(:merchant, name: "Paper Clips and More")

    query = "Sunny"

    get "/api/v1/merchants/find_all?name=#{query}"

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    merchant_results = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_results[:data].count).to eq(5)
    expect(merchant_results[:data])

    merchant_results[:data].each do |record|
      expect(record[:type]).to eq('merchant')
      expect(record[:attributes][:name]).to eq('Sunny Bakery')
      expect(record[:attributes][:name]).to_not eq('Paper Clips and More')
    end
  end
end
