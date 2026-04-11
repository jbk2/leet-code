require 'byebug'
module OrderHelper
  def compute_order(order, inventory)
    order.items.each do |item|
      product = inventory.product(item[:item_code])
      raise StandardError, "No product exists with item code; #{item[:item_code]}" unless product
      name, product_packs = product[:name], product[:packs]
      pack_vols = product_packs.map{|p| p[:item_count]}
      item[:name] = name
      item[:packs] = compute_packs(product_packs, item[:quantity])
      item[:item_total] = compute_item_total(product_packs, item[:packs])
    end
    order.update_order_total
    order
  end

  private
  def compute_item_total(product_packs, item_packs)
    total = 0
    
    item_packs.each do |item_pack|
      product_pack = product_packs.find do |pack|
        pack[:item_count] == item_pack[:pack_size]
      end
      if product_pack.nil?
        raise KeyError, "no catalog pack for size #{item_pack[:pack_size].inspect}" 
      end
      total += product_pack[:price] * item_pack[:pack_quantity]
    end
    
    total.round(2)
  end

  # Optimal definition:
  # - all items must get packed
  # - least number of packs
  def compute_packs(product_packs, quantity)
    pack_vols = product_packs.map { |pack| pack[:item_count] }.uniq
    if pack_vols.none? { |el| el <= quantity }
      raise ArgumentError, "quantity must be above at least one pack size"
    end

    order_packs = []
    pack_mix_array = bfs(pack_vols, quantity)
    unless pack_mix_array
      raise ArgumentError, "item volume not cleanly divisible amongst product pack sizes"
    end

    pack_mix_array.each do |order_pack|
      product_pack = product_packs.find { |product_pack| product_pack[:item_count] == order_pack[:pack_size] }
      order_packs << { pack_size: order_pack[:pack_size],
        pack_price: product_pack[:price],
        pack_quantity: order_pack[:pack_quantity] }
    end
    order_packs
  end

  def bfs(pack_sizes, quantity)
    remainder = quantity
    queue = [[remainder, 0]]
    visited = { remainder => true }
    parents = {}

    until queue.empty?
      remainder, pack_count = queue.shift

      if remainder == 0
        return reconstruct_pack_combo(parents, quantity)
      end

      pack_sizes.each do |pack_size|
        next if pack_size > remainder
        remaining_items = remainder - pack_size
        next if visited[remaining_items]              
        visited[remaining_items] = true
        # store history to enable reconstruction
        parents[remaining_items] = [remainder, pack_size]
        # add new remaining_items count & pack depth to queue so
        # it can be iterated over with pack_sizes
        queue << [remaining_items, pack_count + 1]
      end
    end
  end
  
  def reconstruct_pack_combo(parents, quantity)
    mix = Hash.new(0)
    remainder_count = 0
    
    # walk back up parent tree starting at the pack size that took
    # remaining items to 0, until remainder_count meets the ordered item quantity
    while remainder_count != quantity
      prev, pack = parents[remainder_count]
      mix[pack] += 1
      remainder_count = prev
    end
    
    mix.map { |k, v| { pack_size: k, pack_quantity: v } }
  end
end