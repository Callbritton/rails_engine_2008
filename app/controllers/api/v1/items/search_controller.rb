class Api::V1::Items::SearchController < ApplicationController
  def show
    item = Item.find_by("#{attribute} ILIKE '%#{value}%'")
    render json: ItemSerializer.new(item)
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
