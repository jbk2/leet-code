require_relative "../lib/order_helper"
require_relative "../lib/order"
require_relative "../lib/bakery"
RSpec.describe OrderHelper do
  let(:inventory) { Inventory.new('../spec/inventory.json') } 
  let(:helper_host) do
    Class.new do
      include OrderHelper
      def initialize(inventory)
        @inventory = inventory
      end
    end.new(inventory)
  end
  describe ":compute_order" do
    xit "populates an order's total price and it's items names, pack mix, and item total" do
      order = Order.from_file("../spec/test_data/order1.json")
      pre_compute_order_items = [{ item_code: "vs5", name: "", quantity: 10, packs: [], item_total: 0 },
        { item_code: "mb11", name: "", quantity: 14, packs: [], item_total: 0 },
        { item_code: "cf", name: "", quantity: 13, packs: [], item_total: 0 }]
      
      post_compute_order_items = [{ item_code: "vs5", name: "vegemite scroll", quantity: 10, packs: [{ pack_size: 5, pack_price: 8.99, pack_quantity: 2 }], item_total: 17.98 },
        { item_code: "mb11", name: "blueberry muffin", quantity: 14, packs: [{ pack_size: 8, pack_price: 24.95, pack_quantity: 1 }, { pack_size: 2, pack_price: 9.95 , pack_quantity: 3 }], item_total: 34.90 },
        { item_code: "cf", name: "croissant", quantity: 13, packs: [{ pack_size: 5, pack_price: 9.95, pack_quantity: 2 }, { pack_size: 3, pack_price: 5.95, pack_quantity: 1 }], item_total: 15.90 }]

      # subject(:order_from_file) do
      #   Order.from_file(json_file_path)
      # end
      expect(order.items).to eq(pre_compute_order_items)
      helper_host.compute_order(order)
      expect(order.items).to eq(post_compute_order_items)
    end
  end

  describe ":match_packs" do
    it "returns an array of hashes of pack_size and quantity" do
      expect(helper_host.assign_packs([3, 5], 10)).to eq([{ pack_size: 5, quantity: 2 }])
      expect(helper_host.assign_packs([7, 12], 19)).to eq([{ pack_size: 12, quantity: 1 }, { pack_size: 7, quantity: 1 }])
    end
    
    it "should raise Argument Error if quantity is below smallest pack size" do
      expect { helper_host.assign_packs([7, 12], 5) }
        .to raise_error(ArgumentError, "quantity must be above at least one pack size")
    end
    it "should raise Argument Error if there are leftover packs that don't fit in oack mix" do
      expect { helper_host.assign_packs([7, 12], 10) }
        .to raise_error(ArgumentError, /quantity doesn't divide into pack sizes, with;
        x3 item quantity left over/)
    end
  end
end