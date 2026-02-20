# Given an integer array nums and an integer k, return the k most frequent elements. You may return the answer in any order.
# Constraints:
# 1 <= nums.length <= 105
# -104 <= nums[i] <= 104
# k is in the range [1, the number of unique elements in the array].
# It is guaranteed that the answer is unique.

def top_k_freq_els(array, k)
  map = Hash.new(0)
  top_vals = {}
  lowest = { val: Float::INFINITY, key: 'start' }
  
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
      # remove lowest and add this one
      top_vals.delete(lowest[:key])
      lowest[:val] = val
      lowest[:key] = key
      top_vals[key] = val    
    end
  end

  return top_vals.keys

end

# Example 1:
nums_1 = [1,1,1,2,2,3]
k_1 = 2
answer_1 = [1,2]
output_1 = top_k_freq_els(nums_1, k_1)
puts output_1 == answer_1 ? "✅yes correct top #{k_1} vals are #{output_1}" : "❌ no, correct top #{k_1} vals are not #{output_1}, they shoudl be #{answer_1}"

# Example 2:
nums_2 = [1]
k_2 = 1
answer_2 = [1]
output_2 = top_k_freq_els(nums_2, k_2)
puts output_2 == answer_2 ? "✅yes correct top #{k_2} vals are #{output_2}" : "❌ no, correct top #{k_2} vals are not #{output_2}, they shoudl be #{answer_2}"

# Example 3:
nums_3 = [1,2,1,2,1,2,3,1,3,2]
k_3 = 2
answer_3 = [1,2]
output_3 = top_k_freq_els(nums_3, k_3)
puts output_3 == answer_3 ? "✅yes correct top #{k_3} vals are #{output_3}" : "❌ no, correct top #{k_3} vals are not #{output_3}, they shoudl be #{answer_3}"
 

 

# Follow up: Your algorithm's time complexity must be better than O(n log n), where n is the array's size.