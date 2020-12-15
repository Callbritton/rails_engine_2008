require "rails_helper"

describe "Find endpoints" do
  before :each do
    @merchant1 = create(:merchant, name: "Gamestop")
    @merchant2 = create(:merchant, name: "Unfortunate Corporate Greed Mill")
    @merchant3 = create(:merchant, name: "Jim's Game Emporium")
    @item1 = create(:item, name: "Nintendo Switch", description: "Handheld Fun!", unit_price: 299.99, created_at: "Mon", updated_at: "2018", merchant_id: @merchant1.id)
    @item2 = create(:item, name: "Playstation 5", description: "Sony's newest offering!", unit_price: 379.88, created_at: "Tue", updated_at: "2019",merchant_id: @merchant1.id)
    @item3 = create(:item, name: "Xbox One", description: "Tried and true", unit_price: 489.19, created_at: "Wed", updated_at: "2020",merchant_id: @merchant2.id)
    @item4 = create(:item, name: "Xbox Series X", description: "Microsoft's newest offering", unit_price: 529.69, created_at: "Thur", updated_at: "2020",merchant_id: @merchant2.id)
  end

  it "can find a merchant by name regardless of case or fragmentation" do
    attribute = :name
    value = "unFoR"

    get "/api/v1/merchants/find?#{attribute}=#{value}"

    expect(response).to be_successful

    parsed_data = JSON.parse(response.body, symbolize_names: true)
    result = parsed_data[:data]

    expect(result[:id].to_i).to eq(@merchant2.id)
    expect(result[:attributes][:name]).to eq(@merchant2.name)
    expect(result[:attributes][:name]).to_not eq(@merchant1.name)
    expect(result[:attributes][:name]).to_not eq(@merchant3.name)
  end

  it "can find multiple merchants by name regardless of case or fragmentation" do
    attribute = :name
    value = "gAMe"

    get "/api/v1/merchants/find_all?#{attribute}=#{value}"

    expect(response).to be_successful

    parsed_data = JSON.parse(response.body, symbolize_names: true)
    result = parsed_data[:data]

    expect(result.count).to eq(2)

    result.each do |merchant|
      expect([@merchant1, @merchant3].include? Merchant.find(merchant[:id])).to be_truthy
    end

    result.each do |merchant|
      expect([@merchant2].include? Merchant.find(merchant[:id])).to be_falsey
    end
  end
end
