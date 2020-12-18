class RevenueFacade
  def self.merchant_revenue(id)
    merchant = Merchant.find_by(id: id)
    revenue = merchant.revenue
    RevenueSerializer.new(Revenue.new(revenue))
  end

  def self.total_revenue_by_date(start, stop)
    revenue = Invoice.total_revenue_by_date(beginning_of_day(start), end_of_day(stop))
    total_revenue = Revenue.new(revenue)
    RevenueSerializer.new(total_revenue)
  end

  def self.beginning_of_day(date)
    "#{date} 00:00:00"
  end

  def self.end_of_day(date)
    "#{date} 23:59:59"
  end
end
