require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of all merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)
    merchants = merchants[:data]
    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a String
    end
  end

  it 'can get one merchant by its id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"
    merchant = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    expect(merchant).to have_key(:name)
    expect(merchant[:name]).to be_a String
  end

  it 'can create a new merchant' do
    merchant_params = ({
                        name: "One Special Merchant"
                      })

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/merchants", headers: headers, params: JSON.generate(merchant: merchant_params)
    created_merchant = Merchant.last
    # require "pry"; binding.pry
    expect(response).to be_successful
    expect(created_merchant.name).to eq(merchant_params[:name])
  end
end
