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

  def sift_up(index)
    if @heap_arr[index] > parent
      @heap_arr[index], @heap_arr[parent_index(index)] = @heap_arr[parent_index(index)], @heap_arr[index]
    end
  end

  def sift_down(i)
    n = @heap.length

    loop do
      l, r = left_index(i), right_index(i)
      break if l >= n

      child = r < n && @heap[l] < @heap[r] ? r : l

      break if @heap[i] >= @heap[child]

      @heap[i], @heap[child] = @heap[child], @heap[i]
      i = child
    end
  end

  def parent_index(i)
    (i - 1) / 2
  end

  def left_index(i)
    2 * i + 1
  end

  def right_index(i)
    2 * i + 2
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



# Sort an Array Leet # 
# Given an array of integers nums, sort the array in ascending order and return it.
# You must solve the problem without using any built-in functions in O(nlog(n)) time complexity and with the smallest space complexity possible.

# Example 1:
nums_1 = [5,2,3,1]
output_1 = [1,2,3,5]
# Explanation: After sorting the array, the positions of some numbers are not changed (for example, 2 and 3), while the positions of other numbers are changed (for example, 1 and 5).
ex_unsorted = %w(1 6 2 9 24 12 6 15 18 26).map(&:to_i)
puts "before; #{ex_unsorted.inspect}"
mh = MaxHeap.new(ex_unsorted)
puts "after; #{mh.heap.inspect}"


# Example 2:
nums_2 = [5,1,1,2,0,0]
output_2 =  [0,0,1,1,2,5]
# Explanation: Note that the values of nums are not necessarily unique.

# Constraints:
# 1 <= nums.length <= 5 * 104
# -5 * 104 <= nums[i] <= 5 * 104