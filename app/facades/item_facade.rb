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
end
