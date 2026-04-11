module OrderHelper
  def compute_order(order)
    order.items.each do |item|
      product = @inventory.product(item[:item_code])
      raise StandardError, "No product exists with item code; #{item[:item_code]}" unless product
      # p "product here==> #{product}"
      # p "packs here==> #{packs}"
      # p "item here==> #{item}"
      
      name, packs = product[:name], product[:packs]
      
      item[:name] = name

    end
    # error if not all items match ids in inventory
    # map name from inventory to order items 
    # optimally apply pack items to oacks from itinerary
    # (error if pack split not possible)
    # calc total price per item
    # calc total price on order
    # save updated order to @orders
  end

  def assign_packs(packs, quantity)
    if packs.none? { |el| el <= quantity }
      raise ArgumentError, "quantity must be above at least one pack size"
    end
    
    order_packs = []
    remainder = quantity
    sorted_packs = packs.sort { |a, b| b <=> a }

    # while remainder > 0
    sorted_packs.each do |pack|
      next if pack > remainder
      quantity = remainder / pack
      order_packs << { pack_size: pack, quantity: quantity }
      remainder = remainder % pack
    end
    
    if remainder > 0
      raise ArgumentError, "quantity doesn't divide into pack sizes, with;
        x#{remainder} item quantity left over" if remainder > 0      
    end

    order_packs
  end

end