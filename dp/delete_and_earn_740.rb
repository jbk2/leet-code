# @param {Integer[]} nums
# @return {Integer}

def delete_and_earn(nums)
  count = Hash.new(0)
  nums.each { |n| count[n] += n }
  keys = count.keys.sort

  running_val_inc_prev = 0
  running_val_excl_prev = 0

  keys.each_with_index do |key, i|
    curr_val = count[key]
    can_take_prev = (i == 0) || keys[i - 1] != key - 1
    best_from_prev = [running_val_inc_prev, running_val_excl_prev].max

    if can_take_prev
      # prev key is a gap, so we can take it & current if we want it
      running_inc_curr = best_from_prev + curr_val
    else
      # prev key is current-1, so if we want current we cannot take prev
      running_inc_curr = running_val_excl_prev + curr_val
    end

    running_excl_curr = best_from_prev
    running_val_inc_prev = running_inc_curr
    running_val_excl_prev = running_excl_curr
  end

  [running_val_excl_prev, running_val_inc_prev].max
end

# Example 1:
n1 = [3,4,2]
result1 = 6
# Explanation: You can perform the following operations:
# - Delete 4 to earn 4 points. Consequently, 3 is also deleted. nums = [2].
# - Delete 2 to earn 2 points. nums = [].
# You earn a total of 6 points.

# Example 2:
n2 = [2,2,3,3,3,4]
result2 = 9
# Explanation: You can perform the following operations:
# - Delete a 3 to earn 3 points. All 2's and 4's are also deleted. nums = [3,3].
# - Delete a 3 again to earn 3 points. nums = [3].
# - Delete a 3 once more to earn 3 points. nums = [].
# You earn a total of 9 points.
# 

puts delete_and_earn(n1) == result1 ? "✅passes, with #{n1}, result = #{result1}" : "❌fails with #{n1}, result = #{result1}"
puts delete_and_earn(n2) == result2 ? "✅passes, with #{n2}, result = #{result2}" : "❌fails with #{n2}, result = #{result2}"
# 
# puts delete_and_earn(n1).inspect