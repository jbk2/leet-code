# Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.
# You may assume that each input would have exactly one solution, and you may not use the same element twice.
# You can return the answer in any order.

# Constraints:
# 2 <= nums.length <= 104
# -109 <= nums[i] <= 109
# -109 <= target <= 109
# Only one valid answer exists.
 
def two_sum(nums, target)
  nums_indexes = {}

  nums.each_with_index do |num, index|
    compliment = target - num
    if nums_indexes[compliment]
      return [nums_indexes[compliment], index]
    else
      nums_indexes[num] = index
    end
  end
end

# Example 1:
nums_1 = [2,7,11,15]
target_1 = 9
result_1 = [0,1]
# Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].
test_1 = two_sum(nums_1, target_1)
puts test_1 == result_1 ? "✅passes, with result = #{test_1}" : "❌fails with result = #{test_1}"

# Example 2:
nums_2 = [3,2,4]
target_2 = 6
result_2 = [1,2]
test_2 = two_sum(nums_2, target_2)
puts test_2 == result_2 ? "✅passes, with result = #{test_2}" : "❌fails with result = #{test_2}"

# Example 3:
nums_3 = [3,3]
target_3 = 6
result_3 = [0,1]
test_3 = two_sum(nums_3, target_3)
puts test_3 == result_3 ? "✅passes, with result = #{test_3}" : "❌fails with result = #{test_3}"
 

# Follow-up: Can you come up with an algorithm that is less than O(n2) time complexity?