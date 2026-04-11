require "json"

class Inventory
  def initialize(json_file_path)
    @products = import_inventory(json_file_path)
  end

  def product(code)
    @products[code.to_sym]
  end

  attr_reader :products

  private
  def import_inventory(json_file_path)
    path = File.expand_path(json_file_path, __dir__)
    data = JSON.parse(File.read(path), symbolize_names: true)

    data[:products].each_with_object({}) do |product, products|
      key = product[:code].downcase.to_sym

      products[key] = {
        name: product[:name].downcase,
        packs: product[:packs].map do |pack|
          { item_count: pack[:item_count], price: pack[:price] }
        end
      }
    end
  end
end