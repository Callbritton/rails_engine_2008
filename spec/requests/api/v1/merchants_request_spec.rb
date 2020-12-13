require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    parsed_data = JSON.parse(response.body, symbolize_names: true)
    merchants = parsed_data[:data]

    expect(merchants.count).to eq(3)

    expect(parsed_data).to be_a(Hash)
    expect(parsed_data[:data]).to be_an(Array)
  end

  it "can get one merchant by it's id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    parsed_data = JSON.parse(response.body, symbolize_names: true)
    merchant_by_id = parsed_data[:data][:attributes][:id]

    expect(response).to be_successful
    expect(parsed_data).to have_key(:data)
    expect(parsed_data).to be_a(Hash)
    expect(parsed_data[:data]).to be_an(Hash)

    expect(merchant_by_id).to eq(id)
  end

  it "can create a new merchant" do
    merchant_params = { name: "Sheetz"}
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/merchants", headers: headers, params: JSON.generate(merchant_params)
    created_merchant = Merchant.last

    expect(response).to be_successful

    parsed_data = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_data).to have_key(:data)
    expect(parsed_data[:data]).to be_an(Hash)

    expect(created_merchant.name).to eq(merchant_params[:name])
  end

  it "can update an existing merchant" do
    id = create(:merchant).id
    previous_name = Merchant.last.name
    merchant_params = { name: "Shell"}
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/merchants/#{id}", headers: headers, params: JSON.generate(merchant_params)

    merchant = Merchant.find_by(id: id)

    expect(response).to be_successful

    parsed_data = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_data).to have_key(:data)
    expect(parsed_data[:data]).to be_an(Hash)

    expect(merchant.name).to_not eq(previous_name)
    expect(merchant.name).to eq("Shell")
  end

  it "can destroy an merchant" do
    merchant = create(:merchant)

    expect(Merchant.count).to eq(1)

    delete "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful
    expect(Merchant.count).to eq(0)
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  describe "Relationships" do
    it "can return all items associated with a merchant" do
      merchant = create(:merchant)
      create_list(:item, 3, merchant_id: merchant.id)

      get "/api/v1/merchants/#{merchant.id}/items"

      expect(response).to be_successful

      parsed_data = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_data).to have_key(:data)
      expect(parsed_data[:data]).to be_an(Array)
      expect(parsed_data[:data].length).to eq(3)
    end
  end
end
