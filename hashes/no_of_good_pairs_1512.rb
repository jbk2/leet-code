# Given an array of integers nums, return the number of good pairs.
# A pair (i, j) is called good if nums[i] == nums[j] and i < j.

def good_pairs(nums)
  good_count = 0
  length = nums.length
  i = 0

  while i < length
    j = i + 1
    while j < length
      good_count += 1 if nums[i] == nums[j]
      j += 1
    end
    i += 1
  end 

  good_count
end

def good_pairs_2(nums)
  frequency = Hash.new(0)
  good_count = 0

  nums.each do |num|
    good_count += frequency[num]
    frequency[num] += 1
  end

  good_count
end

# Time complexity: O(n^2)
# Space complexity: O(1)

# Example 1:
nums_1 = [1,2,3,1,1,3]
answer_1 = 4
output_1 = good_pairs_2(nums_1)
puts output_1 == answer_1 ? "✅yes there are #{output_1} good counts" : "❌ no, there are #{answer_1} good counts, not #{output_1}"
# Explanation: There are 4 good pairs (0,3), (0,4), (3,4), (2,5) 0-indexed.

# Example 2:
nums_2 = [1,1,1,1]
answer_2 = 6
output_2 = good_pairs_2(nums_2)
puts output_2 == answer_2 ? "✅yes there are #{output_2} good counts" : "❌ no, there are #{answer_2} good counts, not #{output_2}"
# Explanation: Each pair in the array are good.

# Example 3:
nums_3 = [1,2,3]
answer_3 = 0
output_3 = good_pairs_2(nums_3)
puts output_3 == answer_3 ? "✅yes there are #{output_3} good counts" : "❌ no, there are #{answer_3} good counts, not #{output_3}"
 

# Constraints:

# 1 <= nums.length <= 100
# 1 <= nums[i] <= 100