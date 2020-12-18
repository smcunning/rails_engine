class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates :name, presence: true

  def self.total_revenue_by_date(start, stop)
    Merchant.joins(invoices: [:invoice_items, :transactions])
            .where('transactions.result =? AND invoices.created_at BETWEEN ? AND ?', 'success', start, stop)
            .sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def most_items(limit)
    Invoice.joins(:invoice_items, :transactions)
           .where("transactions.result='success'")
           .group(:merchant_id)
           .order('sum(invoice_items.quantity) desc')
           .limit(limit)
           .sum('invoice_items.quantity')
  end

  def get_revenue
    invoices.joins(:invoice_items, :transactions)
    .where("transactions.result='success' and invoices.status='shipped'")
    .sum("unit_price * quantity")
  end

  def self.most_revenue(quantity)
    Merchant.select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue")
            .joins(invoices: [:invoice_items, :transactions])
            .where("transactions.result='success' and invoices.status='shipped'")
            .group(:id)
            .order("total_revenue desc")
            .limit(quantity)
  end

  def self.find_merchant(attribute, query)
    if attribute == "created_at" || attribute == "updated_at"
      find_by("DATE(#{attribute}) = ?", "%#{query}%")
    else
      find_by("#{attribute} ILIKE ?", "%#{query}%")
    end
  end

  def self.find_all_merchants(attribute, query)
    if attribute == "created_at" || attribute == "updated_at"
      where("DATE(#{attribute}) = ?", "%#{query}%")
    else
      where("#{attribute} ILIKE ?", "%#{query}%")
    end
  end
end
