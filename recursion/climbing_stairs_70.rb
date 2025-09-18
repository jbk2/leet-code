# @param {Integer} n
# @return {Integer}

# def climb_stairs(n, memo = {})
#   return 0 if n.zero?
#   return n if n < 3

#   memo[n] ||= climb_stairs(n - 1, memo) + climb_stairs(n - 2, memo)
# end

# top down
# def climb_stairs(n, memo = [])
#   return 0 if n.zero?
#   return n if n < 3

#   memo[n] ||= climb_stairs(n - 1, memo) + climb_stairs(n - 2, memo)
# end

# bottom up
def climb_stairs(n)
  memo = []
  memo[1] = 1
  memo[2] = 2

  (3..n).each do |i|
    memo[i] = memo[i - 1] + memo[i - 2]
  end

  memo[n]
end

puts climb_stairs(5)
