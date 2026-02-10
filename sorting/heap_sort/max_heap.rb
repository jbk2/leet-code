class MaxHeap
  attr_reader :heap
  
  def initialize(arr)
    @heap = arr
    max_heapify
  end
  
  def max
    @heap[0]
  end

  def remove_max
    @heap[0], @heap[-1] = @heap[-1], @heap[0]
    max = @heap.pop
    sift_down(0)
    return max
  end

  def insert
    # add to end of heap_arr, calc parent
    # # if larger than parent then swap (sift up or sift down)- repeat until in order
  end

  def sift_up(i)
    while i > 0
      p = (i - 1) / 2
      break if @heap[p] >= @heap[i]
      
      @heap[i], @heap[p] = @heap[p], @heap[i]
      i = p
    end
  end

  def sift_down(i)
    n = @heap.length

    loop do
      l, r = l_idx(i), r_idx(i)
      break if l >= n

      child = (r < n && @heap[l] < @heap[r]) ? r : l

      break if @heap[i] >= @heap[child]

      @heap[i], @heap[child] = @heap[child], @heap[i]
      i = child
    end
  end

  def p_idx(i)
    (i - 1) / 2
  end

  def l_idx(i)
    2 * i + 1
  end

  def r_idx(i)
    2 * i + 2
  end

  def self.is_max_heap?(heap_arr)
    last_idx = heap_arr.length - 1
    last_parent_idx = (last_idx - 1) / 2
    valid_heap = true

    (0..last_parent_idx).each do |i|
      l, r = (2 * i) + 1, (2 * i) + 2
  
      if heap_arr[r]
        if heap_arr[i] >= heap_arr[l] && heap_arr[i] >= heap_arr[r]
          # puts "✅ index; #{i} does adhere to max heap propery,\n it's value #{heap_arr[i]} is greater than its left child #{heap_arr[l]} and its right child #{heap_arr[r]}"
        else
          puts "❌ HEAP INVALID ❌; #{i} does NOT adhere to max heap property,\n it's value #{heap_arr[i]} is smaller one of its children, left; #{heap_arr[l]}, right; #{heap_arr[r]}"
          valid_heap = false
          return
        end
      elsif heap_arr[l]
        if heap_arr[i] >= heap_arr[l]
          # puts "✅ index; #{i} does adhere to max heap propery,\n it's value #{heap_arr[i]} is greater than its only child (left); #{heap_arr[l]}"
        else
          puts "❌ HEAP INVALID ❌; #{i} does NOT adhere to max heap property,\n it's value #{heap_arr[i]} is smaller its only child (left) #{heap_arr[l]}"
          valid_heap = false
          return
        end
      end

    end
    puts "✅ HEAP VALID ✅" if valid_heap
  end
  
  private
  def max_heapify
    last_idx = @heap.length - 1
    last_parent_idx = (last_idx - 1) / 2

    while last_parent_idx >= 0
      sift_down(last_parent_idx)
      last_parent_idx -= 1
    end

  end
end

# =============================== MANUAL TESTS ==========================
# ex_unsorted = %w(1 6 2 9 24 12 6 15 18 26).map(&:to_i)
# puts "before; #{ex_unsorted.inspect}"
# puts "after; #{mh.heap.inspect}"
# MaxHeap.is_max_heap?(ex_unsorted)
# heap_1 = MaxHeap.new(ex_unsorted)
# MaxHeap.is_max_heap?(heap_1.heap)
# puts heap_1.heap.inspect
# max = heap_1.remove_max
# puts "here's the max; #{max}, & the newly adjusted heap #{heap_1.heap}"
# MaxHeap.is_max_heap?(heap_1.heap)
