require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many(:invoices) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "instance methods" do
    it "#most_revenue" do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:merchant)

      item_1 = create(:item, unit_price: 10.00, merchant: merchant_1)
      item_2 = create(:item, unit_price: 15.00, merchant: merchant_2)
      item_3 = create(:item, unit_price: 5.00, merchant: merchant_3)

      5.times { create(:invoice, merchant: merchant_1) }
      5.times { create(:invoice, merchant: merchant_2) }
      5.times { create(:invoice, merchant: merchant_3) }

      merchant_1.invoices.each do |invoice|
        create(:invoice_item, invoice: invoice, item: item_1, quantity: 100)
        create(:transaction, invoice: invoice)
      end

      merchant_2.invoices.each do |invoice|
        create(:invoice_item, invoice: invoice, item: item_2, quantity: 10)
        create(:transaction, invoice: invoice)
      end

      merchant_3.invoices.each do |invoice|
        create(:invoice_item, invoice: invoice, item: item_3, quantity: 1000)
        create(:transaction, invoice: invoice)
      end

      merchants = Merchant.most_revenue(2)
      expect(merchants).to be_an Object
      expect(merchants).to include(merchant_3, merchant_1)
    end
  end
end
