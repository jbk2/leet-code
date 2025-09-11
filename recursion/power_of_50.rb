require 'pry'
# @param {Float} x
# @param {Integer} n
# @return {Float}

def my_pow(x, n)
  result = 1.0

  return result if n.zero?

  base = x.to_f
  negative_exponent = !n.positive?
  exponent = n.abs

  while exponent > 0 do
    if exponent.odd?
      result *= base
      exponent -= 1
    end
    base *= base
    exponent /= 2
  end

  negative_exponent ? 1.0 / result : result
end

puts my_pow(2.0, 10)