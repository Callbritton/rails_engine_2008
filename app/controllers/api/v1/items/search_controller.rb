class Api::V1::Items::SearchController < ApplicationController
  def show
    render json: ItemSerializer.new(Item.attribute_filter(attribute, value))
  end

  def index
    item = Item.where("#{attribute} ILIKE '%#{value}%'")
    render json: ItemSerializer.new(item)
  end

  def attribute
    params.keys[0]
  end

  def value
    params.values[0]
  end
end
