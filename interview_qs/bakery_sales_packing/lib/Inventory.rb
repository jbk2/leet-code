# require_relative "../spec/inventory.json"

class Inventory
  def initialize(json_file_path)
    @products = parse_items(json_file_path)
  end


  attr_reader :products

  private
  def parse_items(json_file_path)
    products = {}
    file = File.read(File.join(__dir__, json_file_path))
    json = JSON.parse(file)
    
    json["products"].each do |product|
      product.transform_keys!(&:to_sym)
      packs = []
      
      product[:packs].each do |pack|
        pack.transform_keys!(&:to_sym)
        packs << { item_count: pack[:item_count], price: pack[:price] }
      end
      
    
      # puts p[:code]
      products[product[:code].downcase.to_sym] = {
        name: product[:name].downcase,
        packs: packs
      }
    end
    products
  end

end