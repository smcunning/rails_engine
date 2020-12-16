class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates :name, presence: true

  def self.most_revenue(quantity)
    Merchant.select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue")
            .joins(invoices: [:invoice_items, :transactions])
            .where("transactions.result='success' and invoices.status='shipped'")
            .group(:id)
            .order("total_revenue desc")
            .limit(quantity)
  end

  def self.find_merchant(query)
    Merchant.find_by("merchants.name::text ILIKE ?", "%#{query}%")
  end
end
