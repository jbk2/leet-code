# Given an integer array nums and an integer k, return the kth largest element in the array.
# Note that it is the kth largest element in the sorted order, not the kth distinct element.
# Solve without sorting.
# Constraints:
# 1 <= k <= nums.length <= 105
# -104 <= nums[i] <= 104

# require_relative "./min_heap"

class MinHeapSized
  attr_reader :heap

  def initialize(arr, k)
    @heap = []
    min_heapify(arr, k)
  end

  def min_heapify(arr, k)
    arr.each do |el|
      # binding.irb
      if @heap.length < k
        # just add it whatever it's value
        @heap << el
        sift_up(@heap.length - 1)
      elsif @heap[0] < el
        @heap[0] = el
        sift_down(0)
      end
    end
  end

  def sift_up(i)
    while i > 0
      p = (i - 1) / 2
      
      if @heap[i] < @heap[p]
        @heap[i], @heap[p] = @heap[p], @heap[i]
      end

      i = p
    end
  end

  def sift_down(i)
    n = @heap.length
    
    loop do
      l, r = (2 * i) + 1, (2 * i) + 2
      break if l >= n
  
      child = l
      if r < n && @heap[r] < @heap[l]
        child = r     
      end

      break if @heap[i] < @heap[child]
    
      @heap[i], @heap[child] = @heap[child], @heap[i]
      i = child
    end
  end
end



def kth_largest(arr, k)
  min_heap = MinHeapSized.new(arr, k)
  min_heap.heap[0]
end

# Example 1:
nums_1 = [3,2,1,5,6,4]
k_1 = 2
answer_1 = 5
output_1 = kth_largest(nums_1, k_1)
# heap = MinHeapSized.new(nums_1, k_1)
# puts heap.heap.inspect
puts output_1 == answer_1 ? "✅passes - with the #{k_1}th largest el being; #{output_1}"
  : "❌fails - output was #{output_1}, but the #{k_1}th largest element is #{answer_1}"



# Example 2:
nums_2 = [3,2,3,1,2,4,5,5,6]
k_2 = 4
answer_2 = 4
heap = MinHeapSized.new(nums_2, k_2)
puts heap.heap.inspect
output_2 = kth_largest(nums_2, k_2)
puts output_2 == answer_2 ? "✅passes - with the #{k_2}th largest el being; #{output_2}"
  : "❌fails - output was #{output_2}, but the #{k_2}th largest element is #{answer_2}"
 
