class Api::V1::Merchants::SearchController < ApplicationController
  def show
    merchant = Merchant.find_by("#{attribute} ILIKE '%#{value}%'")
    render json: MerchantSerializer.new(merchant)
  end

  def index
    merchant = Merchant.where("#{attribute} ILIKE '%#{value}%'")
    render json: MerchantSerializer.new(merchant)
  end

  def attribute
    params.keys[0]
  end

  def value
    params.values[0]
  end
end
