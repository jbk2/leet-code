class Order
  def initialize(order_string)
    @items = parse_order(order_string)
  end


  attr_reader :items

  private
  def parse_order(order_string)
    order_string.split(/\n/).map do |item|
      quantity, code = item.split(" ")

      { item_name: '', item_code: code, quantity: quantity}
    end
  end
end

