require 'rails_helper'

describe "Business Intelligence" do
  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    @merchant4 = create(:merchant)

    @item1 = Item.create(name: "Nintendo Switch", description: "Handheld Fun!", unit_price: 400.00, merchant_id: @merchant1.id)
    @item2 = Item.create(name: "Playstation 5", description: "Sony's newest offering!", unit_price: 300.00, merchant_id: @merchant2.id)
    @item3 = Item.create(name: "Xbox One", description: "Tried and true", unit_price: 200.00, merchant_id: @merchant3.id)
    @item4 = Item.create(name: "Xbox Series X", description: "Microsoft's newest offering", unit_price: 100.00, merchant_id: @merchant4.id)

    @invoice1 = create(:invoice, merchant_id: @merchant1.id, status: 'shipped')
    @invoice2 = create(:invoice, merchant_id: @merchant2.id, status: 'shipped')
    @invoice3 = create(:invoice, merchant_id: @merchant3.id, status: 'shipped')
    @invoice4 = create(:invoice, merchant_id: @merchant4.id, status: 'shipped')

    create(:invoice_item, item: @item1, invoice: @invoice1, quantity: 40, unit_price: @item1.unit_price)
    create(:invoice_item, item: @item2, invoice: @invoice2, quantity: 30, unit_price: @item2.unit_price)
    create(:invoice_item, item: @item3, invoice: @invoice3, quantity: 20, unit_price: @item3.unit_price)
    create(:invoice_item, item: @item4, invoice: @invoice4, quantity: 10, unit_price: @item4.unit_price)

    create(:transaction, invoice_id: @invoice1.id, result: 'success')
    create(:transaction, invoice_id: @invoice2.id, result: 'success')
    create(:transaction, invoice_id: @invoice3.id, result: 'success')
    create(:transaction, invoice_id: @invoice4.id, result: 'success')
  end

  it "returns merchants with the most revenue" do
    quantity = 3

    get "/api/v1/merchants/most_revenue?quantity=#{quantity}"
    expect(response).to be_successful

    parsed_data = JSON.parse(response.body, symbolize_names: true)
    result = parsed_data[:data]

    expect(result).to be_an(Array)
    expect(result.size).to eq(3)

    result.each do |merchant|
      expect([@merchant1, @merchant2, @merchant3].include? Merchant.find(merchant[:id])).to be_truthy
    end

    result.each do |merchant|
      expect([@merchant4].include? Merchant.find(merchant[:id])).to be_falsey
    end

    expect(result[0][:attributes][:name]).to eq(@merchant1.name)
  end
end
