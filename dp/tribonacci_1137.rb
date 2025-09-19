# @param {Integer} n
# @return {Integer}

# Top down DP solution
# def tribonacci(n, memo = [])
#   return 0 if n <= 0
#   return 1 if (1..2).include?(n)
#   return memo[n] unless memo[n].nil?

#   memo[n] = tribonacci(n - 1, memo) + tribonacci(n - 2, memo) + tribonacci(n - 3, memo)
# end

# Bottom up DP solution
def tribonacci(n)
  return 0 if n <= 0
  return 1 if (1..2).include?(n) 
  memo = [0, 1, 1]

  (3..n).each do |n|
    memo[n] = memo[n - 1] + memo[n - 2] + memo[n - 3]
  end

  memo[n]
end

# Example 1:
n1 = 4
result1 = 4
# Explanation:
# T_3 = 0 + 1 + 1 = 2
# T_4 = 1 + 1 + 2 = 4

# Example 2:
n2 = 25
result2 = 1389537
# 
puts tribonacci(n1) == 4 ? "✅passes, with #{n1}, result = #{result1}" : "❌fails with #{n1}, result = #{result1}"
puts tribonacci(n2) == 1389537 ? "✅passes, with #{n2}, result = #{result2}" : "❌fails with #{n2}, result = #{result2}"