class ItemFacade
  def self.all_items
    ItemSerializer.new(Item.all)
  end

  def self.item_by_id(id)
    ItemSerializer.new(Item.find(id))
  end

  def self.create_item(item)
    ItemSerializer.new(Item.create(item))
  end

  def self.update_item(id, item)
    ItemSerializer.new(Item.update(id, item))
  end

  def self.destroy_item(id)
    Item.destroy(id)
  end

  def self.find_item(attribute, query)
    ItemSerializer.new(Item.find_item(attribute, query))
  end

  def self.find_all_items(attribute, query)
    ItemSerializer.new(Item.find_all_items(attribute, query))
  end

  def self.find_by_merchant(merchant_id)
    merchant = Merchant.find(merchant_id)
    ItemSerializer.new(merchant.items)
  end
end
