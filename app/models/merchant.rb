class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  validates :name, presence: true

  def revenue
    invoices
      .joins(:invoice_items, :transactions)
      .merge(Transaction.successful)
      .merge(Invoice.shipped)
      .sum('unit_price * quantity')
  end

  def self.most_revenue(quantity)
    Merchant.select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue')
            .joins(invoices: %i[invoice_items transactions])
            .merge(Transaction.successful)
            .merge(Invoice.shipped)
            .group(:id)
            .order('total_revenue desc')
            .limit(quantity)
  end

  def self.find_merchant(attribute, query)
    if %w[created_at updated_at].include?(attribute)
      find_by("DATE(#{attribute}) = ?", "%#{query}%")
    else
      find_by("#{attribute} ILIKE ?", "%#{query}%")
    end
  end

  def self.find_all_merchants(attribute, query)
    if %w[created_at updated_at].include?(attribute)
      where("DATE(#{attribute}) = ?", "%#{query}%")
    else
      where("#{attribute} ILIKE ?", "%#{query}%")
    end
  end
end
