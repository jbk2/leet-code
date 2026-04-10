class Order
  def self.from_file(json_file_path)
    path = File.join(__dir__, json_file_path)
    unless File.read(path) then raise Errno::ENOENT end
    json_string = File.read(path, symbolize_names: true)
    new(json_string)
  end

  def initialize(json)
    data = 
      case json
      when String then JSON.parse(json, symbolize_names: true)
      when Hash then json
      else
        raise ArgumentError "Order needs a JSON String or Hash (with an order key),
          instead received this class; #{json.class}"
      end

    @items = parse_order(data)
  end


  attr_reader :items

  private
  def parse_order(json_hash)
    json_hash[:order].split(/\n/).map do |item|
      quantity, code = item.split(" ")

      { item_code: code.downcase, quantity: quantity.to_i }
    end
  end
end

