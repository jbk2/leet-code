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
      return [index, num_indexes[compliment]]
    else
      nums_indexes[num] = index
    end
  end
end

# Example 1:
nums_1 = [2,7,11,15]
target_1 = 9
answer_1: [0,1]
# Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].


# Example 2:
nums_2 = [3,2,4]
target_2 = 6
answer_2 = [1,2]

# Example 3:
nums_3 = [3,3]
target_3 = 6
answe_3 = [0,1]
 

# Follow-up: Can you come up with an algorithm that is less than O(n2) time complexity?