require 'json'
require_relative "../lib/bakery.rb"


RSpec.describe Bakery do
  subject(:bakery) do
    Bakery.new('../spec/inventory.json')
  end

  describe "instantiation" do
    it "will throw an error if not given an inventory json file" do
      expect { Bakery.new() }.to raise_error(ArgumentError)
    end
    
    it "will throw an error if not given an inventory json file" do
      empty_json_file_path = 'empty_json_file.json'
      expect { Bakery.new(empty_json_file_path) }.to raise_error(Errno::ENOENT)
    end
    
    it "has a populated inventory" do
      products = bakery.inventory.products
      expect(products).not_to be_nil
    end

    it "instantiates with its orders empty" do
      expect(bakery.orders).to be_empty
    end
  end

  describe ":add_order" do
    xit "creates a valid order and adds it to the bakerys orders" do
      path = File.join(__dir__, '../spec/test_data/order1.json')
      order_json = JSON.parse(File.read(path), symbolize_names: true)
      expect { bakery.add_order(order_json) }
        .to change { bakery.orders}.by(1)
    end
  end
end