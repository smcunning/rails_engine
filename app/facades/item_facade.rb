class ItemFacade
  def self.all_items
    ItemSerializer.new(Item.all)
  end
end
