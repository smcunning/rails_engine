class MerchantFacade
  def self.all_merchants
    MerchantSerializer.new(Merchant.all)
  end

  def self.merchant_by_id(id)
    MerchantSerializer.new(Merchant.find(id))
  end

  def self.create_merchant(merchant)
    MerchantSerializer.new(Merchant.create(merchant))
  end
end
