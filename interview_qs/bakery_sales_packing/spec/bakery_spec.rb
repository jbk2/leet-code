require 'json'
require_relative "../lib/bakery.rb"
require_relative "../lib/order.rb"


RSpec.describe Bakery do
  subject(:bakery) do
    Bakery.new('../spec/inventory.json')
  end

  subject(:order1_json) do
      path = File.join(__dir__, '../spec/test_data/order1.json')
      JSON.parse(File.read(path), symbolize_names: true)
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
    it "creates and adds an order @orders" do
      expect { bakery.new_order(order1_json) } 
        .to change { bakery.orders.count }.by(1)
    end

    it "computes total price and pack breakdown for all of orders items" do
      bakery.new_order(order1_json)
      price = bakery.orders.last.order_total
      expect(price).to be(98.63)
    end
  end

  describe ":print_order" do
    it "outputs the order correctly formatted" do
      order = bakery.new_order(order1_json)
      correct_format = "\n10 VS5 £17.98\n\t2 x 5 £8.99\n14 MB11 £54.8\n\t1 x 8 £24.95\n\t3 x 2 £9.95" \
        "\n13 CF £25.85\n\t2 x 5 £9.95\n\t1 x 3 £5.95"
      
      expect(order.print_order).to eq(correct_format)
    end
  end

end