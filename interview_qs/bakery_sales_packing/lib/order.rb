class Order
  def self.from_file(json_file_path)
    path = File.join(__dir__, json_file_path)
    unless File.read(path) then raise Errno::ENOENT end
    json_string = File.read(path)
    new(json_string)
  end

  def initialize(json)
    data = 
      case json
      when String then JSON.parse(json, symbolize_names: true)
      when Hash then json
      else
        raise ArgumentError, "Order needs a JSON String or Hash (with an order key),
          instead received this class; #{json.class}"
      end

    @items = parse_order(data)
    @order_total = 0
  end

  def update_order_total
    self.order_total = items.map { |item| item[:item_total] }.sum
  end

  # order needs to have been computed by bakery before this can run
  # TODO add protection to ensure order is computed before this runs
  def print_order
    items.map do |item|
      code, quantity, item_total = item[:item_code], item[:quantity], item[:item_total]
      item_str = "\n#{quantity} #{code.upcase} £#{item_total}"
      packs = item[:packs].map do |pack|
        "\n\t#{pack[:pack_quantity]} x #{pack[:pack_size]} £#{pack[:pack_price]}"
      end
      packs_str = packs.join
      item_str + packs_str
    end.join
  end

  attr_reader :items
  attr_accessor :order_total

  private
  def parse_order(json_hash)
    json_hash[:order].split(/\n/).map do |item|
      quantity, code = item.split(" ")

      { item_code: code.downcase, name: "", quantity: quantity.to_i, packs: [], item_total: 0 }
    end
  end
end

