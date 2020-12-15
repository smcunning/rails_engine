class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates :name, presence: true

  def self.most_revenue(quantity)
    Merchant.select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue")
            .joins(invoices: [:invoice_items, :transactions])
            .group(:id)
            .order("total_revenue desc")
            .limit(quantity)
  end

end
