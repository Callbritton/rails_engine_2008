require "rails_helper"

describe "Find endpoints" do
  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @item1 = create(:item, name: "Nintendo Switch", description: "Handheld Fun!", unit_price: 299.99, created_at: "Mon", updated_at: "2018", merchant_id: @merchant1.id)
    @item2 = create(:item, name: "Playstation 5", description: "Sony's newest offering!", unit_price: 379.88, created_at: "Tue", updated_at: "2019",merchant_id: @merchant1.id)
    @item3 = create(:item, name: "Xbox Series X", description: "Handheld Fun!", unit_price: 489.19, created_at: "Wed", updated_at: "2020",merchant_id: @merchant2.id)
  end

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
end
