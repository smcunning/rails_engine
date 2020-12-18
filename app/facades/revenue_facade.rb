class RevenueFacade
  def merchant_revenue(id)
    merchant = Merchant.find_by(id: id)
    revenue = merchant.get_revenue
    Revenue.new(revenue)
  end

  def self.total_revenue_by_date(start, stop)
    revenue = Invoice.total_revenue_by_date(start, stop)
    Revenue.new(revenue)
  end
end
