require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end

  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'instance methods' do
    it ".attribute_filter" do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      item1 = create(:item, name: "Nintendo Switch", description: "Handheld Fun!", unit_price: 299.99, created_at: "Wed", updated_at: "2018", merchant_id: merchant1.id)
      item2 = create(:item, name: "Playstation 5", description: "Sony's newest offering!", unit_price: 379.88, created_at: "Tue", updated_at: "2019",merchant_id: merchant1.id)
      item3 = create(:item, name: "Xbox One", description: "Tried and true", unit_price: 489.19, created_at: "Wed", updated_at: "2020",merchant_id: merchant2.id)

      by_name = Item.attribute_filter(:name, "NintE")
      expect(by_name).to eq(item1)

      by_description = Item.attribute_filter(:description, "SONY")
      expect(by_description).to eq(item2)

      by_unit_price = Item.attribute_filter("unit_price", 489.19)
      expect(by_unit_price).to eq(item3)
    end
  end
end
