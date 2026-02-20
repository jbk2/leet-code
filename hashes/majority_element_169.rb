# Given an array nums of size n, return the majority element.
# The majority element is the element that appears more than ⌊n / 2⌋ times. You may assume that the majority element always exists in the array.

# Constraints:
# n == nums.length
# 1 <= n <= 5 * 104
# -109 <= nums[i] <= 109
# The input is generated such that a majority element will exist in the array.

def majority_el(nums)
  majority_count = nums.length / 2
  
  count_map = Hash.new(0)
  nums.each { |num| count_map[num] += 1 }
  count_map.each do |k, v|
    return k if v > majority_count
  end
end

# Example 1:
nums_1 = [3,2,3]
answer_1 = 3
output_1 = majority_el(nums_1)
puts output_1 == answer_1 ? "✅yes correct majority count is #{output_1}" : "❌ no, correct majority count is #{answer_1} not #{output_1}"

# Example 2:
nums_2 = [2,2,1,1,1,2,2]
answer_2 = 2
output_2 = majority_el(nums_2)
puts output_2 == answer_2 ? "✅yes correct majority count is #{output_2}" : "❌ no, correct majority count is #{answer_2} not #{output_2}"
 

# Follow-up: Could you solve the problem in linear time and in O(1) space?