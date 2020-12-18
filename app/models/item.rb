class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  def self.find_all_items(attribute, query)
    if %w[created_at updated_at].include?(attribute)
      where("DATE(#{attribute}) = ?", "%#{query}%")
    else
      where("#{attribute} ILIKE ?", "%#{query}%")
    end
  end

  def self.find_item(attribute, query)
    if %w[created_at updated_at created_at updated_at created_at updated_at].include?(attribute)
      find_by("DATE(#{attribute}) = ?", "%#{query}%")
    else
      find_by("#{attribute} ILIKE ?", "%#{query}%")
    end
  end
end
