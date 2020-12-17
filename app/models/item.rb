class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  def self.find_all_items(attribute, query)
    if attribute == "created_at" || attribute == "updated_at"
      where("DATE(#{attribute}) = ?", "%#{query}%")
    else
      where("#{attribute} ILIKE ?", "%#{query}%")
    end
  end

  def self.find_item(attribute, query)
    if attribute == "created_at" || attribute == "updated_at"
      find_by("DATE(#{attribute}) = ?", "%#{query}%")
    else
      find_by("#{attribute} ILIKE ?", "%#{query}%")
    end
  end
end
