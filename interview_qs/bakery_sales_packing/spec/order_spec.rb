require 'json'
require_relative "../lib/order.rb"
RSpec.describe "Order" do
  file = File.read(File.join(__dir__, "/order1.json"))
  order_json = JSON.parse(file)["order"]
  p order_json

  subject(:order) do
    Order.new(order_json)
  end

  describe "instantiation" do
    xit "parses order input in a string into Ruby Object order hash items" do
      parsed_items = [
        { item_name: 'vegemite scroll', item_code: 'VS5', quantity: 10 },
        { item_name: 'blueberry muffin' , item_code: 'MB11', quantity: 14 },
        { item_name: 'croissant', item_code: 'CF', quantity: 13 }
      ]
      # expect(order.items.count).to eq(3)
      expect(order.items).to eq(parsed_items)
    end
  end
end