class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :name

  def self.most_revenue(quantity)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .where("transactions.result='success' AND invoices.status='shipped'")
      .group('merchants.id')
      .order('revenue DESC')
      .limit(quantity)
  end

  def self.most_items(quantity)
    select("merchants.*, SUM(invoice_items.quantity) AS total_items")
      .joins(invoices: [:invoice_items, :transactions])
      .where("transactions.result='success' AND invoices.status='shipped'")
      .group("merchants.id")
      .order("total_items DESC")
      .limit(quantity)
  end

  def self.revenue_across_range(start_date, end_date)
    Merchant.joins(invoices: [:invoice_items, :transactions])
      .where(invoices: {created_at: start_date.to_datetime.beginning_of_day..end_date.to_datetime.end_of_day})
      .where("transactions.result='success' AND invoices.status='shipped'")
      .sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def total_revenue
    invoices.joins(:invoice_items, :transactions)
      .where("transactions.result='success' AND invoices.status='shipped'")
      .sum("invoice_items.unit_price * invoice_items.quantity")
  end
end
