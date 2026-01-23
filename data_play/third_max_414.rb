# Given an integer array nums, return the third distinct maximum number in this array. If the third maximum does not exist, return the maximum number.
 
def third_max(nums)
  sorted_uniques = nums.sort.uniq
  sorted_uniques[-3] || sorted_uniques.max
end

# Example 1:
nums_1 = [3,2,1]
result_1 = 1
output_1 = third_max(nums_1)
puts output_1 == result_1 ? "✅passes - #{nums_1} is the 3rd max"
  : "❌fails - result is #{output_1} but 3rd max should be #{result_1}"
# Explanation:
# The first distinct maximum is 3.
# The second distinct maximum is 2.
# The third distinct maximum is 1.

# Example 2:
nums_2 = [1,2]
result_2 = 2
output_2 = third_max(nums_2)
puts output_2 == result_2 ? "✅passes - #{nums_2} is the 3rd max"
  : "❌fails - result is #{output_2} but 3rd max should be #{result_2}"
# Explanation:
# The first distinct maximum is 2.
# The second distinct maximum is 1.
# The third distinct maximum does not exist, so the maximum (2) is returned instead.
# Example 3:

nums_3 = [2,2,3,1]
result_3 = 1
output_3 = third_max(nums_3)
puts output_3 == result_3 ? "✅passes - #{nums_3} is the 3rd max"
  : "❌fails - result is #{output_3} but 3rd max should be #{result_3}"
# Explanation:
# The first distinct maximum is 3.
# The second distinct maximum is 2 (both 2's are counted together since they have the same value).
# The third distinct maximum is 1.
 
# Constraints:
# 1 <= nums.length <= 104
# -231 <= nums[i] <= 231 - 1