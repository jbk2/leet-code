# @param {Integer[]} cost
# @return {Integer}
def min_cost_climbing_stairs(cost)
  n = cost.length

  return 0 if n.zero?
  return cost[0] if n == 1

  prev2 = cost[0]
  prev1 = cost[1]

  (2...n).each do |i|
    curr = cost[i] + [prev2, prev1].min
    prev2, prev1 = prev1, curr
  end

  [prev2, prev1].min
end

# Example 1:
cost1 = [10,15,20]
# Output: 15
# Explanation: You will start at index 1.
# - Pay 15 and climb two steps to reach the top.
# The total cost is 15.

# Example 2:
cost2 = [1,100,1,1,1,100,1,1,100,1]
# Output: 6
# Explanation: You will start at index 0.
# - Pay 1 and climb two steps to reach index 2.
# - Pay 1 and climb two steps to reach index 4.
# - Pay 1 and climb two steps to reach index 6.
# - Pay 1 and climb one step to reach index 7.
# - Pay 1 and climb two steps to reach index 9.
# - Pay 1 and climb one step to reach the top.
# The total cost is 6.

result1 = min_cost_climbing_stairs(cost1)
puts result1 == 15 ? "✅ Test passed, with #{cost1}, result=>#{result1}" : "❌ Test failed, with #{cost1}, result=>#{result1}"
result2 = min_cost_climbing_stairs(cost2)
puts result2 == 6 ? "✅ Test passed, with #{cost2}, result=>#{result2}" : "❌ Test failed, with #{cost2}, result=>#{result2}"