## iterative version - rapid overflow!!!
# def nth_row_string(n)
#   return '0' if n == 1

#   prev = nth_row_string(n - 1)
#   prev.concat(prev.tr('01', '10'))
# end

# def kth_grammar(n, k)
#   nth_row_string(n)[k - 1].to_i
# end

def kth_grammar(n, k)
  return 0 if n == 1

  half_length = 1 << (n - 2)

  if k <= half_length
    kth_grammar(n - 1, k)
  else
    1 - kth_grammar(n - 1, k - half_length)
  end
end

# pattern is look at previous, i.e. n - 1 then duplicate it,
# changing the digits to inverse
# 0
# 01
# 01 | 10
# 0110 | 1001
# 01101001 | 10010110
# 0110100110010110 | 1001011001101001

j = kth_grammar(9, 15)

puts j.inspect