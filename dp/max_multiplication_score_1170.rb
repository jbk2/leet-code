# @param {Integer[]} nums
# @param {Integer[]} multipliers
# @return {Integer}

# def maximum_score(nums, multipliers)
#   total = 0

#   multipliers.each_with_index do |m, i|
#     return if nums.empty?

#     if (nums[0] * m) >= (nums[-1] * m)
#       n = nums.slice!(0)
#     else
#       n = nums.pop
#     end

#     total += n * m
#   end
#     total
# end

def maximum_score(nums, multipliers)
  n = nums.length
  m = multipliers.length
  memo = Array.new(m + 1) { Array.new(m + 1) }

  f = lambda do |picks, from_left|
    return 0 if picks == m
    return memo[picks][from_left] unless memo[picks][from_left].nil?

    from_right = picks - from_left
    left_index_edge = from_left
    right_index_edge = n - 1 - from_right

    memo[picks][from_left] = [
      nums[left_index_edge] * multipliers[picks] + f.call(picks + 1, from_left + 1),
      nums[right_index_edge] * multipliers[picks] + f.call(picks + 1, from_left)
    ].max
  end

  f.call(0, 0)
end

# Example 1:
n1 = [1,2,3]
m1 = [3,2,1]
result1 = 14
# Explanation: An optimal solution is as follows:
# - Choose from the end, [1,2,3], adding 3 * 3 = 9 to the score.
# - Choose from the end, [1,2], adding 2 * 2 = 4 to the score.
# - Choose from the end, [1], adding 1 * 1 = 1 to the score.
# The total score is 9 + 4 + 1 = 14.

# Example 2:
n2 = [-5,-3,-3,-2,7,1]
m2 = [-10,-5,3,4,6]
result2 = 102
# Explanation: An optimal solution is as follows:
# - Choose from the start, [-5,-3,-3,-2,7,1], adding -5 * -10 = 50 to the score.
# - Choose from the start, [-3,-3,-2,7,1], adding -3 * -5 = 15 to the score.
# - Choose from the start, [-3,-2,7,1], adding -3 * 3 = -9 to the score.
# - Choose from the end, [-2,7,1], adding 1 * 4 = 4 to the score.
# - Choose from the end, [-2,7], adding 7 * 6 = 42 to the score. 
# The total score is 50 + 15 - 9 + 4 + 42 = 102.

score1 = maximum_score(n1, m1)
score2 = maximum_score(n2, m2)

puts score1 == result1 ? "✅passes, with nums;#{n1} & multiplier;#{m1}, result = #{score1}" : "❌fails with #{n1}, result = #{score1}"
puts score2 == result2 ? "✅passes, with nums;#{n2} & multiplier;#{m2}, result = #{score2}" : "❌fails with #{n2}, result = #{score2}"