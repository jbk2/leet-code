# @param {Integer} n
# @return {Integer}

def climb_stairs(n, memo = {})
  return 0 if n.zero?
  return n if n < 3

  memo[n] ||= climb_stairs(n - 1, memo) + climb_stairs(n - 2, memo)
end

puts climb_stairs(5)
