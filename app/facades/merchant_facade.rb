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

  def self.update_merchant(id, merchant)
    MerchantSerializer.new(Merchant.update(id, merchant))
  end

  def self.delete_merchant(id)
    MerchantSerializer.new(Merchant.destroy(id))
  end
end
