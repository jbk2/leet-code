class MaxHeap
  attr_reader :heap
  
  def initialize(arr)
    @heap = arr
    max_heapify
  end
  
  def max
    @heap[0]
  end

  def insert
    # add to end of heap_arr
    # calc parent
    # if larger than parent then swap (sift up or sift down)- repeat until in order
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

      child = r < n && @heap[l] < @heap[r] ? r : l

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
  
    (0..last_parent_idx).each do |i|
      l, r = (2 * i) + 1, (2 * 1) + 2
  
      if heap_arr[r]
        if heap_arr[i] >= heap_arr[l] && heap_arr[i] >= heap_arr[r]
          puts "✅ index; #{i} does adhere to max heap propery,\n it's value #{heap_arr[i]} is greater than its left child #{heap_arr[l]} and its right child #{heap_arr[r]}"
        else
          puts "❌index; #{i} does NOT adhere to max heap property,\n it's value #{heap_arr[i]} is smaller one of its children, left; #{heap_arr[l]}, right; #{heap_arr[r]}"
        end
      elsif heap_arr[l]
        if heap_arr[i] >= heap_arr[l]
          puts "✅ index; #{i} does adhere to max heap propery,\n it's value #{heap_arr[i]} is greater than its only child (left); #{heap_arr[l]}"
        else
          puts "❌ index; #{i} does NOT adhere to max heap property,\n it's value #{heap_arr[i]} is smaller its only child (left) #{heap_arr[l]}"
        end
      end
    end
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


ex_unsorted = %w(1 6 2 9 24 12 6 15 18 26).map(&:to_i)
# puts "before; #{ex_unsorted.inspect}"
# puts "after; #{mh.heap.inspect}"
MaxHeap.is_max_heap?(ex_unsorted)
heap_1 = MaxHeap.new(ex_unsorted)
MaxHeap.is_max_heap?(heap_1.heap)
puts heap_1.heap.inspect



# Sort an Array Leet # 
# Given an array of integers nums, sort the array in ascending order and return it.
# You must solve the problem without using any built-in functions in O(nlog(n)) time complexity and with the smallest space complexity possible.

# Example 1:
nums_1 = [5,2,3,1]
output_1 = [1,2,3,5]
# Explanation: After sorting the array, the positions of some numbers are not changed (for example, 2 and 3), while the positions of other numbers are changed (for example, 1 and 5).


# Example 2:
nums_2 = [5,1,1,2,0,0]
output_2 =  [0,0,1,1,2,5]
# Explanation: Note that the values of nums are not necessarily unique.

# Constraints:
# 1 <= nums.length <= 5 * 104
# -5 * 104 <= nums[i] <= 5 * 104