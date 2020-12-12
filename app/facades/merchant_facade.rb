class MerchantFacade
  def self.all_merchants
    MerchantSerializer.new(Merchant.all)
  end
end
