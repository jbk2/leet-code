# Given an integer array nums and an integer k, return the k most frequent elements. You may return the answer in any order.
# Constraints:
# 1 <= nums.length <= 105
# -104 <= nums[i] <= 104
# k is in the range [1, the number of unique elements in the array].
# It is guaranteed that the answer is unique.

def top_k_freq_els(array, k)
  map = Hash.new(0)
  top_vals = {}
  lowest = { val: Float::INFINITY, key: nil }
  
  array.each do |num|
    map[num] += 1
  end
  
  map.each do |key, val|
    if top_vals.length < k
      top_vals[key] = val    
      
      if val < lowest[:val]
        lowest[:val] = val
        lowest[:key] = key
      end 
    elsif val > lowest[:val]
      top_vals.delete(lowest[:key])
      top_vals[key] = val
      lowest_key, lowest_val = top_vals.min_by{ |_, v| v }
      lowest[:val] = lowest_val
      lowest[:key] = lowest_key
    end
  end

  return top_vals.keys
end

# Time efficiency: O(n) + O(unique_vals * k)
# Space efficiency: O(unique_vals + k)
# 

class MinHeap
  attr_accessor :heap

  def initialize
    @heap = []
  end

  def peek
    @heap[0]
  end

  def length
    @heap.length
  end

  def pop
    return nil if @heap.empty?
    head = @heap[0]
    tail = @heap.pop
    
    if !@heap.empty?
      @heap[0] = tail
      sift_down(0)
    end

    return head
  end
  
  def sift_up(i)
    while i > 0
      p = parent(i)
      break if @heap[p][:frequency] <= @heap[i][:frequency]
      @heap[i], @heap[p] = @heap[p], @heap[i]
      i = p
    end
  end

  def sift_down(i)
    size = @heap.length

    loop do
      l, r = left(i), right(i)
      break if l >= size

      least_child = (r < size && @heap[r][:frequency] < @heap[l][:frequency]) ? r : l
      
      break if @heap[least_child][:frequency] > @heap[i][:frequency]
      
      @heap[i], @heap[least_child] = @heap[least_child], @heap[i]
      i = least_child
    end
  end

  def left(i)
    (i * 2) + 1
  end
  
  def right(i)
    (i * 2) + 2
  end

  def parent(i)
    (i - 1) / 2
  end
end

def top_k_freq_els_2(array, k)
  num_freqs = Hash.new(0)
  array.each { |num| num_freqs[num] += 1 }
  min_heap = MinHeap.new

  num_freqs.each do |num, freq|
    current = { number: num, frequency: freq }
    
    if min_heap.length < k
      min_heap.heap << current
      min_heap.sift_up(min_heap.length - 1)
    elsif freq > min_heap.peek[:frequency]
      min_heap.pop
      min_heap.heap << current
      min_heap.sift_up(min_heap.length - 1)
    end
  end

  min_heap.heap.map { |el| el[:number] }
end

# Example 1:
nums_1 = [1,1,1,2,2,3]
k_1 = 2
answer_1 = [1,2]
output_1 = top_k_freq_els_2(nums_1, k_1)
puts output_1.sort == answer_1.sort ? "✅yes correct top #{k_1} vals are #{output_1}" : "❌ no, correct top #{k_1} vals are not #{output_1}, they shoudl be #{answer_1}"

# Example 2:
nums_2 = [1]
k_2 = 1
answer_2 = [1]
output_2 = top_k_freq_els_2(nums_2, k_2)
puts output_2.sort == answer_2.sort ? "✅yes correct top #{k_2} vals are #{output_2}" : "❌ no, correct top #{k_2} vals are not #{output_2}, they shoudl be #{answer_2}"

# Example 3:
nums_3 = [1,2,1,2,1,2,3,1,3,2]
k_3 = 2
answer_3 = [1,2]
output_3 = top_k_freq_els_2(nums_3, k_3)
puts output_3.sort == answer_3.sort ? "✅yes correct top #{k_3} vals are #{output_3}" : "❌ no, correct top #{k_3} vals are not #{output_3}, they shoudl be #{answer_3}"
 
puts top_k_freq_els_2(nums_1, k_1).inspect
 

# Follow up: Your algorithm's time complexity must be better than O(n log n), where n is the array's size.