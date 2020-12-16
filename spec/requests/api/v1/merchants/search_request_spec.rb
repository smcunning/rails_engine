require 'rails_helper'

describe "Merchant Find Single Endpoint" do
  it 'can return a single merchant that fits search params - case-sensitive/partial' do
    merchant1 = create(:merchant, name: "Apple Pie House")
    merchant2 = create(:merchant, name: "Jon's Dice World")
    merchant3 = create(:merchant, name: "House of Dice")

    #Happy Path
    search = 'Apple'

    get "/api/v1/merchants/find?name=#{search}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)[:data][0]

    expect(merchant).to be_a Hash
    expect(merchant[:id]).to eq(merchant1.id.to_s)
    expect(merchant[:id]).to_not eq(merchant2.id.to_s)
    expect(merchant[:id]).to_not eq(merchant3.id.to_s)
    expect(merchant[:attributes][:name]).to eq(merchant1.name)
    expect(merchant[:attributes][:name]).to_not eq(merchant3.name)
    expect(merchant[:attributes][:name].downcase).to include(search.downcase)

    #Case-Sensitivity/Partial
    search = "ApP"

    get "/api/v1/merchants/find?name=#{search}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)[:data][0]

    expect(merchant).to be_a Hash
    expect(merchant[:id]).to eq(merchant1.id.to_s)
    expect(merchant[:id]).to_not eq(merchant2.id.to_s)
    expect(merchant[:id]).to_not eq(merchant3.id.to_s)
    expect(merchant[:attributes][:name]).to eq(merchant1.name)
    expect(merchant[:attributes][:name]).to_not eq(merchant3.name)
    expect(merchant[:attributes][:name].downcase).to include(search.downcase)
  end
end
