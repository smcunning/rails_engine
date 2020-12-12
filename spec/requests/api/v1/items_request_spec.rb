require 'rails_helper'

describe 'Items API' do
  it 'sends a list of all items' do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful
    items = JSON.parse(response.body, symbolize_names: true)
    items = items[:data]
    expect(items.count).to eq(3)

    items.each do |item|
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a String

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a String

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a Float
    end
  end

  it 'can get one item by its id' do
    id = create(:item).id

    get "/api/v1/items/#{id}"
    item = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    expect(item).to have_key(:name)
    expect(item[:name]).to be_a String

    expect(item).to have_key(:description)
    expect(item[:description]).to be_a String

    expect(item).to have_key(:unit_price)
    expect(item[:unit_price]).to be_a Float
  end
end
