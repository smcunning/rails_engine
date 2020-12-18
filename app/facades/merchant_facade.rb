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

  def self.find_all_merchants(attribute, query)
    merchants = Merchant.find_all_merchants(attribute, query)
    MerchantSerializer.new(merchants)
  end

  def self.find_merchant(attribute, query)
    merchant = Merchant.find_merchant(attribute, query)
    MerchantSerializer.new(merchant)
  end

  def self.find_by_item(item_id)
    item = Item.find_by(id: item_id)
    merchant = Merchant.find_by(id: item.merchant_id)
    MerchantSerializer.new(merchant)
  end

  def self.most_revenue(quantity)
    MerchantSerializer.new(Merchant.most_revenue(quantity))
  end

  def self.most_items(quantity)
    merchant_ids = Invoice.most_items(quantity)
    merchants = Merchant.find([merchant_ids.keys])
    MerchantSerializer.new(merchants)
  end
end
