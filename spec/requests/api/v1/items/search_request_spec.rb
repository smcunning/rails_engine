require 'rails_helper'

describe "Item Find Single Endpoint" do
  it 'can return a single item that fits search params - case-sensitive/partial' do
    item1 = create(:item, name: 'Green Button', created_at: "2020-12-15")
    item2 = create(:item, name: 'Orange Button', unit_price: 15.20)
    item3 = create(:item, name: 'Red Button', updated_at: "2020-01-29", description: "Shiniest red button you'll ever see")

    #Happy Path
    search = 'Green Button'

    get "/api/v1/items/find?name=#{search}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(item).to be_a Hash
    expect(item[:id]).to eq(item1.id.to_s)
    expect(item[:id]).to_not eq(item2.id.to_s)
    expect(item[:id]).to_not eq(item3.id.to_s)
    expect(item[:attributes][:name]).to eq(item1.name)
    expect(item[:attributes][:name]).to_not eq(item3.name)
    expect(item[:attributes][:name].downcase).to include(search.downcase)

    #Case-Sensitivity/Partial
    search = "gREe bUttO"

    get "/api/v1/items/find?name=#{search}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(item).to be_a Hash
    expect(item[:id]).to eq(item1.id.to_s)
    expect(item[:id]).to_not eq(item2.id.to_s)
    expect(item[:id]).to_not eq(item3.id.to_s)
    expect(item[:attributes][:name]).to eq(item1.name)
    expect(item[:attributes][:name]).to_not eq(item3.name)
    expect(item[:attributes][:name].downcase).to include(search.downcase)

    #unit_price
    unit_price = 15.20
    get "/api/v1/items/find?unit_price=#{unit_price}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(item).to be_a Hash
    expect(item[:id]).to eq(item2.id.to_s)
    expect(item[:id]).to_not eq(item1.id.to_s)
    expect(item[:id]).to_not eq(item3.id.to_s)
    expect(item[:attributes][:unit_price]).to eq(item2.unit_price)
    expect(item[:attributes][:unit_price]).to_not eq(item3.unit_price)


    #description
    description = "Shiniest"
    get "/api/v1/items/find?description=#{description}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(item).to be_a Hash
    expect(item[:id]).to eq(item3.id.to_s)
    expect(item[:id]).to_not eq(item2.id.to_s)
    expect(item[:id]).to_not eq(item3.id.to_s)
    expect(item[:attributes][:description]).to eq(item3.description)
    expect(item[:attributes][:unit_price]).to_not eq(item2.description)

    #created_at
    created_at = "2020-12-15"
    updated_at = "2020-01-29"

    get "/api/v1/items/find?created_at=#{created_at}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(item).to be_a Hash
    expect(item[:id]).to eq(item1.id.to_s)
    expect(item[:id]).to_not eq(item2.id.to_s)
    expect(item[:attributes][:name]).to eq(item1.name)

    #updated_at
    get "/api/v1/items/find?updated_at=#{updated_at}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(item).to be_a Hash
    expect(item[:id]).to eq(item3.id.to_s)
    expect(item[:id]).to_not eq(item1.id.to_s)
    expect(item[:attributes][:name]).to eq(item3.name)
  end
end
