def num_trees(n, memo = {})
  return 1 if n <= 1
  return memo[n] if memo[n]

  total = 0

  (0..n-1).each do |l|
    total += num_trees(l, memo) * num_trees(n - 1 - l, memo)
  end

  memo[n] = total
end

puts num_trees(5)