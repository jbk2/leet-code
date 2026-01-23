# Given an array nums. We define a running sum of an array as runningSum[i] = sum(nums[0]…nums[i]).
# Return the running sum of nums.

def running_sum(nums)
  sum_arr = []
  
  nums.length.times do |i|
    sum_arr << nums.slice(0, i + 1).sum
  end

  sum_arr
end 

# Example 1:
nums_1 = [1,2,3,4]
result_1 = [1,3,6,10]
# Explanation: Running sum is obtained as follows: [1, 1+2, 1+2+3, 1+2+3+4].
test_1 = running_sum(nums_1)
puts test_1 == result_1 ? "✅passes - sum is - #{test_1}" : "❌fails - sum is - #{test_1}, but should be #{result_1}"

# Example 2:
nums_2 = [1,1,1,1,1]
result_2 = [1,2,3,4,5]
# Explanation: Running sum is obtained as follows: [1, 1+1, 1+1+1, 1+1+1+1, 1+1+1+1+1].
test_2 = running_sum(nums_2)
puts test_2 == result_2 ? "✅passes - sum is - #{test_2}" : "❌fails - sum is - #{test_2}, but should be #{result_2}"

# Example 3:
nums_3 = [3,1,2,10,1]
result_3 = [3,4,6,16,17]
test_3 = running_sum(nums_3)
puts test_3 == result_3 ? "✅passes - sum is - #{test_3}" : "❌fails - sum is - #{test_3}, but should be #{result_3}"
 
# Constraints:
# 1 <= nums.length <= 1000
# -10^6 <= nums[i] <= 10^6