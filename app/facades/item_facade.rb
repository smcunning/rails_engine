class ItemFacade
  def self.all_items
    ItemSerializer.new(Item.all)
  end

  def self.item_by_id(id)
    ItemSerializer.new(Item.find(id))
  end
end
