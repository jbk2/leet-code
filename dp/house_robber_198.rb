# @param {Integer[]} nums
# @return {Integer}

# bottom up DP approach
# def rob(nums)
#   return nil if nums.empty?
#   return nums[-1] if nums.length == 1

#   max_at_index = []
#   max_at_index[0] = nums[0]
#   max_at_index[1] = [nums[0], nums[1]].max


#   (2..nums.count - 1).each do |i|
#     max_at_index[i] = [max_at_index[i - 1], max_at_index[i - 2] + nums[i]].max
#   end

#   max_at_index[-1]
# end

# top down DP approach
def rob(nums)
  memo = {}

  max_at_i = lambda do |i|
    return 0 if i < 0
    return memo[i] if memo.key?(i)
    memo[i] ||= [max_at_i.call(i - 1), max_at_i.call(i - 2) + nums[i]].max
  end

  max_at_i.call(nums.length - 1)
end


# Example 1:
nums1 = [1,2,3,1]
# Output: 4
# Explanation: Rob house 1 (money = 1) and then rob house 3 (money = 3).
# Total amount you can rob = 1 + 3 = 4.

# Example 2:
nums2 = [2,7,9,3,1]
# Output: 12
# Explanation: Rob house 1 (money = 2), rob house 3 (money = 9) and rob house 5 (money = 1).
# Total amount you can rob = 2 + 9 + 1 = 12.
# 
result1 = rob(nums1)
puts result1 == 4 ? "passes, with #{nums1}, result = #{result1}" : "fails with #{nums1}, result = #{result1}"

result2 = rob(nums2)
puts result2 == 12 ? "passes, with #{nums2}, result = #{result2}" : "fails with #{nums2}, result = #{result2}"