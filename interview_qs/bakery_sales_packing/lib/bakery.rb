require 'random/formatter'
require_relative "order_helper"
class Bakery
  include OrderHelper

  def initialize(inventory_file_path)
    @inventory = Inventory.new(inventory_file_path)
    @orders = []
  end

  def new_order(order_hash)
    order = Order.new(order_hash)
    computed_order = compute_order(order)
    # add name and calculate packs and price on order 
    @orders << order
  end


  attr_reader :inventory, :orders

  private
  
end