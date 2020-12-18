require 'rails_helper'

describe 'Item Multi-Finder Endpoint' do
  it 'can return all records that match attribute queries' do
    5.times do
      create(:item, name: "Happy Panda", unit_price: 184.99, description: "The happiest of pandas", created_at: "2020-12-15")
    end

    item = create(:item, name: "Sad Koala", unit_price: 1982.32, description: "Not a happy koala", updated_at: "2020-01-29")

    query = "PaNdA"

    get "/api/v1/items/find_all?name=#{query}"

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    item_results = JSON.parse(response.body, symbolize_names: true)

    expect(item_results[:data].count).to eq(5)

    item_results[:data].each do |record|
      expect(record[:type]).to eq('item')
      expect(record[:attributes][:name]).to eq('Happy Panda')
      expect(record[:attributes][:name]).to_not eq('Sad Koala')
      expect(record[:attributes][:unit_price]).to eq(184.99)
      expect(record[:attributes][:unit_price]).to_not eq(1982.32)
      expect(record[:attributes][:description]).to eq("The happiest of pandas")
      expect(record[:attributes][:description]).to_not eq("Not a happy koala")

    #created_at/updated_at
    created_at = "2020-12-15"
    updated_at = "2020-01-29"

    get "/api/v1/items/find_all?created_at=#{created_at}"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(items).to be_an Array
    expect(items.count).to eq(5)
    expect(items[0][:attributes][:name]).to eq("Happy Panda")

    #updated_at
    get "/api/v1/items/find_all?updated_at=#{updated_at}"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(items).to be_an Array
    expect(items.count).to eq(1)
    expect(items[0][:attributes][:name]).to eq("Sad Koala")
  end
 end
end
