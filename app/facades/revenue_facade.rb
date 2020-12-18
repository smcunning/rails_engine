class RevenueFacade
  def merchant_revenue(id)
    merchant = Merchant.find_by(id: id)
    revenue = merchant.get_revenue
    Revenue.new(revenue)
  end
end
