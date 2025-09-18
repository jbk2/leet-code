# @param {Integer[]} nums
# @return {Integer}

# bottom up DP approach
def rob(nums)
  return nil if nums.empty?
  return nums[-1] if nums.length == 1

  max_at_index = []
  max_at_index[0] = nums[0]
  max_at_index[1] = [nums[0], nums[1]].max


  (2..nums.count - 1).each do |i|
    max_at_index[i] = [max_at_index[i - 1], max_at_index[i - 2] + nums[i]].max
  end

  max_at_index[-1]
end


# Example 1:
# nums = [1,2,3,1]
# Output: 4
# Explanation: Rob house 1 (money = 1) and then rob house 3 (money = 3).
# Total amount you can rob = 1 + 3 = 4.

# Example 2:
nums = [2,7,9,3,1]
# Output: 12
# Explanation: Rob house 1 (money = 2), rob house 3 (money = 9) and rob house 5 (money = 1).
# Total amount you can rob = 2 + 9 + 1 = 12.
# 
puts rob(nums)