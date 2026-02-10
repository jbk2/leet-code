# Given an integer array nums and an integer k, return the kth largest element in the array.
# Note that it is the kth largest element in the sorted order, not the kth distinct element.
# Solve without sorting.
# Constraints:
# 1 <= k <= nums.length <= 105
# -104 <= nums[i] <= 104

# require_relative "./min_heap"

class MinHeapSized

  def initialize()
    @heap = []
  end

  def add(el)
    # check heap size,
    #   if less than k add and sift_up
    #   if more than k, is el > than smallest, if so add el, sift up then pop off last
    @heap << el

  end



  
end



def kth_largest(arr, k)
  min_heap = MinHeapSized.new(arr)


  
end

# Example 1:
nums_1 = [3,2,1,5,6,4]
k_1 = 2
answer_1 = 5

# Example 2:
nums_2 = [3,2,3,1,2,4,5,5,6]
k_2 = 4
answer_2 = 4
 
