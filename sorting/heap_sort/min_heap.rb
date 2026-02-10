class MinHeap
  attr_reader :heap
  
  def initialize(arr)
    @heap = arr
    min_heapify
  end

  def min_heapify
    n = @heap.length
    last_idx = n - 1

    last_parent_idx = (last_idx - 1) / 2
    last_parent_idx.downto(0) do
      |i| sift_down(i)
    end
  end

  def sift_up(i)
    while i > 0
      p = (i - 1) / 2
      break if @heap[p] < @heap[i]
      @heap[p], @heap[i] = @heap[i], @heap[p]
      i = p
    end
  end

  def sift_down(i)
    n = @heap.length

    loop do
      l, r = (2 * i) + 1, (2* i) + 2
      break if l >= n

      child = (r < n && @heap[r] < @heap[l]) ? r : l

      break if @heap[child] > @heap[i]
      
      @heap[child], @heap[i] = @heap[i], @heap[child]
      i = child      
    end
  end

  def remove_min
    @heap[0], @heap[-1] = @heap[-1], @heap[0]
    min = @heap.pop
    sift_down(0)
    return min
  end

  def is_min_heap?
    last_idx = @heap.length - 1
    last_parent_idx = (last_idx - 1) / 2
    valid_heap = true

    (0..last_parent_idx).each do |i|
      l, r = (2 * i) + 1, (2 * i) + 2
  
      if @heap[r]
        if @heap[i] <= @heap[l] && @heap[i] <= @heap[r]
          puts "✅ index; #{i} does adhere to min heap propery,\n it's value #{@heap[i]} is smaller than its left child #{@heap[l]} and its right child #{@heap[r]}"
        else
          puts "❌ HEAP INVALID ❌; #{i} does NOT adhere to min heap property,\n it's value #{@heap[i]} is larger one of its children, left; #{@heap[l]}, right; #{@heap[r]}"
          valid_heap = false
          return
        end
      elsif @heap[l]
        if @heap[i] <= @heap[l]
          puts "✅ index; #{i} does adhere to min heap propery,\n it's value #{@heap[i]} is smaller than its only child (left); #{@heap[l]}"
        else
          puts "❌ HEAP INVALID ❌; #{i} does NOT adhere to min heap property,\n it's value #{@heap[i]} is greater than its only child (left) #{@heap[l]}"
          valid_heap = false
          return
        end
      end

    end
    puts "✅ HEAP VALID ✅" if valid_heap
  end

end

# =============================== MANUAL TESTS ==========================
# ex_unsorted = %w(1 6 2 9 24 12 6 15 18 26).map(&:to_i)
# puts "before; #{ex_unsorted.inspect}"
# puts "after; #{mh.heap.inspect}"
# MinHeap.is_min_heap?(ex_unsorted)
# heap_1 = MinHeap.new(ex_unsorted)
# heap_1.is_min_heap?
# puts heap_1.heap.inspect
# max = heap_1.remove_max
# puts "here's the max; #{max}, & the newly adjusted heap #{heap_1.heap}"
# MaxHeap.is_max_heap?(heap_1.heap)
