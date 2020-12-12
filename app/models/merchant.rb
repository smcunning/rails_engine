class Merchant < ApplicationRecord
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates :name, presence: true
end
