require 'json'
require_relative "../lib/order.rb"
RSpec.describe "Order" do
  json_file_path = "../spec/test_data/order1.json"

  subject(:order_from_file) do
    Order.from_file(json_file_path)
  end
  
  subject(:order_json_string) do
    path = File.join(__dir__, '../spec/test_data/order1.json')
    json_string = File.read(path)
  end
  
  subject(:order_from_json) do
    Order.new(order_json_string)
  end

  describe "instantiation" do
    context "from raw json" do
      it "can create an order from either raw JSON or a JSON file" do
        order = Order.new(order_json_string)
        expect(order.items).to be_truthy
      end
    end
    
    context "from a JSON file" do
      it "raises an error if the file is non-existent" do
        expect { Order.from_file('non_existent_file.json')}.to raise_error(Errno::ENOENT)
      end
  
      it "raises when the file is empty" do
        empty_file_path = "../spec/test_data/empty_file.json"
        expect { Order.from_file(empty_file_path) }.to raise_error(JSON::ParserError)
      end
  
      it "parses order input in a string into Ruby Object order hash items" do
        parsed_items = [
          { item_code: 'vs5', name: "", quantity: 10, packs: [], item_total: 0 },
          { item_code: 'mb11', name: "", quantity: 14, packs: [], item_total: 0},
          { item_code: 'cf', name: "", quantity: 13, packs: [], item_total: 0}
        ]
        # expect(order.items.count).to eq(3)
        expect(order_from_file.items).to eq(parsed_items)
      end
    end
  end

end