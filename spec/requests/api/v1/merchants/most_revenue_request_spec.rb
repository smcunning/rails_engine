require 'rails_helper'

describe 'Merchant BI Endpoints' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)

    @item_1 = create(:item, unit_price: 10.00, merchant: @merchant_1)
    @item_2 = create(:item, unit_price: 15.00, merchant: @merchant_2)
    @item_3 = create(:item, unit_price: 5.00, merchant: @merchant_3)

    5.times { create(:invoice, merchant: @merchant_1) }
    5.times { create(:invoice, merchant: @merchant_2) }
    5.times { create(:invoice, merchant: @merchant_3) }

    @merchant_1.invoices.each do |invoice|
      create(:invoice_item, invoice: invoice, item: @item_1, quantity: 100)
      create(:transaction, invoice: invoice)
    end
    @merchant_2.invoices.each do |invoice|
      create(:invoice_item, invoice: invoice, item: @item_2, quantity: 10)
      create(:transaction, invoice: invoice)
    end
    @merchant_3.invoices.each do |invoice|
      create(:invoice_item, invoice: invoice, item: @item_3, quantity: 1000)
      create(:transaction, invoice: invoice)
    end
  end

  it 'can return a list of merchants with most revenue by quantity' do

    get "/api/v1/merchants/most_revenue?quantity=3"

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].first[:id]).to eq(@merchant_3.id.to_s)
    expect(merchants[:data][1][:id]).to eq(@merchant_1.id.to_s)
    expect(merchants[:data].last[:id]).to eq(@merchant_2.id.to_s)
  end


  it 'can return a list of merchants by their quantity of items' do
    get '/api/v1/merchants/most_items?quantity=3'

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants[:data].first[:id]).to eq(@merchant_3.id.to_s)
    expect(merchants[:data].first[:attributes]).to have_key(:name)
    expect(merchants[:data][0][:attributes][:name]).to be_a String
  end

  it 'can return total_revenue within a date range' do
    start = Date.today - 60
    stop = Date.today + 60

    get "/api/v1/revenue?start=#{start}&end=#{stop}"

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    revenue = JSON.parse(response.body, symbolize_names: true)

    expect(revenue[:data][:attributes]).to have_key :revenue
    expect(revenue[:data][:attributes][:revenue]).to be_a Float 
  end
end
