require "rails_helper"

describe "Item find endpoints" do
  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @item1 = create(:item, name: "Nintendo Switch", description: "Handheld Fun!", unit_price: 299.99, created_at: "Wed, 16 Dec 2020 00:00:00 UTC +00:00", updated_at: "Wed, 16 Dec 2020 15:34:47 UTC +00:00", merchant_id: @merchant1.id)
    @item2 = create(:item, name: "Playstation 5", description: "Sony's newest offering!", unit_price: 379.88, created_at: "Tue", updated_at: "2019",merchant_id: @merchant1.id)
    @item3 = create(:item, name: "Xbox One", description: "Tried and true", unit_price: 489.19, created_at: "Wed", updated_at: "2020",merchant_id: @merchant2.id)
    @item4 = create(:item, name: "Xbox Series X", description: "Microsoft's newest offering", unit_price: 529.69, created_at: "Thur", updated_at: "2020",merchant_id: @merchant2.id)
  end

# Single Finders

  it "can find an item by name regardless of case or fragmentation" do
    attribute = :name
    value = "nInT"

    get "/api/v1/items/find?#{attribute}=#{value}"

    expect(response).to be_successful

    parsed_data = JSON.parse(response.body, symbolize_names: true)
    result = parsed_data[:data]

    expect(result[:id].to_i).to eq(@item1.id)
    expect(result[:attributes][:name]).to eq(@item1.name)
    expect(result[:attributes][:name]).to_not eq(@item2.name)
    expect(result[:attributes][:name]).to_not eq(@item3.name)
  end

  it "can find an item by description regardless of case or fragmentation" do
    attribute = :description
    value = "hAnDhEld"

    get "/api/v1/items/find?#{attribute}=#{value}"

    expect(response).to be_successful

    parsed_data = JSON.parse(response.body, symbolize_names: true)
    result = parsed_data[:data]
    expect(result[:id].to_i).to eq(@item1.id)
    expect(result[:attributes][:description]).to eq(@item1.description)
    expect(result[:attributes][:description]).to_not eq(@item2.description)
    expect(result[:attributes][:description]).to_not eq(@item3.description)
  end

  it "can find an item by unit price" do
    attribute = "unit_price"
    value = 299.99

    get "/api/v1/items/find?#{attribute}=#{value}"

    expect(response).to be_successful

    parsed_data = JSON.parse(response.body, symbolize_names: true)
    result = parsed_data[:data]

    expect(result[:id].to_i).to eq(@item1.id)
    expect(result[:attributes][:unit_price]).to eq(@item1.unit_price)
    expect(result[:attributes][:unit_price]).to_not eq(@item2.unit_price)
    expect(result[:attributes][:unit_price]).to_not eq(@item3.unit_price)
  end

  xit "can find an item by created at" do
    attribute = "created_at"
    value = "Wed, 16 Dec 2020 00:00:00 UTC +00:00"

    get "/api/v1/items/find?#{attribute}=#{value}"

    expect(response).to be_successful

    parsed_data = JSON.parse(response.body, symbolize_names: true)
    result = parsed_data[:data]

    expect(result[:id].to_i).to eq(@item1.id)
    expect(result[:attributes][:created_at]).to eq(@item1.created_at)
    expect(result[:attributes][:created_at]).to_not eq(@item2.created_at)
    expect(result[:attributes][:created_at]).to_not eq(@item3.created_at)
  end

# Multi Finders

  it "can find multiple items by name regardless of case or fragmentation" do
    attribute = :name
    value = "xBox"

    get "/api/v1/items/find_all?#{attribute}=#{value}"

    expect(response).to be_successful

    parsed_data = JSON.parse(response.body, symbolize_names: true)
    result = parsed_data[:data]

    expect(result.count).to eq(2)

    result.each do |item|
      expect([@item3, @item4].include? Item.find(item[:id])).to be_truthy
    end

    result.each do |item|
      expect([@item1, @item2].include? Item.find(item[:id])).to be_falsey
    end
  end

  it "can find multiple items by description regardless of case or fragmentation" do
    attribute = :description
    value = "Newe"

    get "/api/v1/items/find_all?#{attribute}=#{value}"

    expect(response).to be_successful

    parsed_data = JSON.parse(response.body, symbolize_names: true)
    result = parsed_data[:data]

    expect(result.count).to eq(2)

    result.each do |item|
      expect([@item2, @item4].include? Item.find(item[:id])).to be_truthy
    end

    result.each do |item|
      expect([@item1, @item3].include? Item.find(item[:id])).to be_falsey
    end
  end
end
