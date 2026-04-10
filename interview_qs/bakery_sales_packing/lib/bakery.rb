class Bakery
  def initialize(inventory_file_path)
    @inventory = Inventory.new(inventory_file_path)
    @orders = []
  end

  
  attr_reader :inventory, :orders
end