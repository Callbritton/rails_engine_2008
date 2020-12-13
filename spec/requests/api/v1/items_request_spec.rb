require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get '/api/v1/items'

    expect(response).to be_successful

    parsed_data = JSON.parse(response.body, symbolize_names: true)
    items = parsed_data[:data]

    expect(items.count).to eq(3)

    expect(parsed_data).to be_a(Hash)
    expect(parsed_data[:data]).to be_an(Array)
  end

  it "can get one item by it's id" do
    merchant = create(:merchant)
    id = create(:item, merchant_id: merchant.id).id

    get "/api/v1/items/#{id}"

    parsed_data = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(parsed_data).to have_key(:data)
    expect(parsed_data).to be_a(Hash)
    expect(parsed_data[:data]).to be_an(Hash)
  end

  it "can create a new item" do
    merchant = create(:merchant)
    item_params = ({
                    name: 'The Unstoppable Force!',
                    description: "... it's in the description",
                    unit_price: 9999999999.99,
                    merchant_id: merchant.id
                   })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item_params)
    created_item = Item.last

    expect(response).to be_successful

    parsed_data = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_data).to have_key(:data)
    expect(parsed_data[:data]).to be_an(Hash)

    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it "can update an existing item" do
    merchant = create(:merchant)
    id = create(:item, merchant_id: merchant.id).id
    previous_name = Item.last.name
    item_params = { name: "The Immovable Object"}
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate(item_params)

    item = Item.find_by(id: id)

    expect(response).to be_successful

    parsed_data = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_data).to have_key(:data)
    expect(parsed_data[:data]).to be_an(Hash)

    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("The Immovable Object")
  end

  it "can destroy an item" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  describe "Relationships" do
    it "can return the merchant associated with an item" do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)

      get "/api/v1/items/#{item.id}/merchants"

      expect(response).to be_successful

      parsed_data = JSON.parse(response.body, symbolize_names: true)
      merchant_by_id = parsed_data[:data][:id].to_i

      expect(parsed_data).to have_key(:data)
      expect(parsed_data[:data]).to be_an(Hash)
      expect(merchant_by_id).to eq(merchant.id)
    end
  end
end
