class Api::V1::Merchants::BusinessController < ApplicationController
  def most_revenue
    render json: MerchantSerializer.new(Merchant.most_revenue(params[:quantity]))
  end

  def most_items
    render json: MerchantSerializer.new(Merchant.most_items(params[:quantity]))
  end

  def revenue_across_range
    render json: RevenueSerializer.new(Merchant.revenue_across_range(params[:start], params[:end]))
  end

  def total_revenue
    merchant = Merchant.find(params[:id])
    render json: RevenueSerializer.new(merchant.total_revenue)
  end
end
