require "json"
require "tempfile"
require_relative "../lib/inventory.rb"

RSpec.describe Inventory do
  subject(:inventory) do
    Inventory.new("../spec/inventory.json")
  end

  describe "instantiation" do
    it "raises an error if the file is non-existent" do
      expect { Inventory.new('non_existent_file.json')}.to raise_error(Errno::ENOENT)
    end
    it "raises when the file is empty" do
      empty_file_path = "../spec/test_data/empty_file.json"
      expect { Inventory.new(empty_file_path) }.to raise_error(JSON::ParserError)
    end

    it "parses its file input into @products with a :products reader" do
      products = {
        vs5: { name: "vegemite scroll", packs: [ { item_count: 3, price: 6.99 }, { item_count: 5, price: 8.99 } ]},
        mb11: { name: "blueberry muffin", packs: [ { item_count: 2, price: 9.95 }, { item_count: 5, price: 16.95 }, { item_count: 8, price: 24.95 } ]},
        cf: { name: "croissant", packs: [ { item_count: 3, price: 5.95 }, { item_count: 5, price: 9.95 }, { item_count: 9, price: 16.99 } ]}
      }
      expect(inventory.products).to eq(products)
    end

    it ":product(code) returns the correct product" do
      muffin = { name: "blueberry muffin", packs: [ { item_count: 2, price: 9.95 }, { item_count: 5, price: 16.95 }, { item_count: 8, price: 24.95 } ]}
      expect(inventory.product('mb11')).to eq(muffin)
    end
  end
end