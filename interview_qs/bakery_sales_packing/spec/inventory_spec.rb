require_relative "../lib/inventory.rb"
RSpec.describe Inventory do
  subject(:inventory) do
    Inventory.new("../spec/inventory.json")
  end
  describe "instantiation" do
    it "parses its file input into @products with a :products reader" do
      products = {
        vs5: { name: "vegemite scroll", packs: [ { item_count: 3, price: 6.99 }, { item_count: 5, price: 8.99 } ]},
        mb11: { name: "blueberry muffin", packs: [ { item_count: 2, price: 9.95 }, { item_count: 5, price: 16.95 }, { item_count: 8, price: 24.95 } ]},
        cf: { name: "croissant", packs: [ { item_count: 3, price: 5.95 }, { item_count: 5, price: 9.95 }, { item_count: 9, price: 16.99 } ]}
      }
  
      expect(inventory.products).to eq(products)  
    end
  end
end