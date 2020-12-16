class Api::V1::Items::MerchantsController < ApplicationController
  def show
    merchant = Item.find(params[:id]).merchant
    render json: MerchantSerializer.new(merchant)
    #mserializer = MerchantSerializer.new(merchant)
    #to_be_rendered = mserializer.jsonify
    #render: to_be_rendered
  end
end
