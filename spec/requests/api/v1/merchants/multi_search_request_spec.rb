require 'rails_helper'

describe 'Merchant Multi-Finder Endpoint' do
  it 'can return all records that match attribute queries' do
    5.times do
      create(:merchant, name: "Sunny Bakery", created_at: "2020-12-15")
    end

    merchant = create(:merchant, name: "Paper Clips and More", updated_at: "2020-01-29")

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

    #created_at
    created_at = "2020-12-15"
    updated_at = "2020-01-29"

    get "/api/v1/merchants/find_all?created_at=#{created_at}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchants).to be_an Array
    expect(merchants.count).to eq(5)
    expect(merchants[0][:attributes][:name]).to eq("Sunny Bakery")
    expect(merchants[0][:attributes][:name]).to_not eq(merchant.name)

    #updated_at
    get "/api/v1/merchants/find_all?updated_at=#{updated_at}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchants).to be_an Array
    expect(merchants.count).to eq(1)
    expect(merchants[0][:attributes][:name]).to eq("Paper Clips and More")
    expect(merchants[0][:attributes][:name]).to_not eq("Sunny Bakery")
  end
end
