# Given an integer array nums and an integer k, return the k most frequent elements. You may return the answer in any order.
 

def k_most_freq_els(nums, k)
  freqs = Hash.new(0)
  
  nums.each { |n| freqs[n] += 1 }

  freqs.sort_by { |key, val| -val }.first(k).map(&:first)
end

# Example 1:
nums_1 = [1,1,1,2,2,3]
k_1 = 2
result_1 = [1,2]

output_1 = k_most_freq_els(nums_1, k_1)
puts output_1 == result_1 ? "✅passes - #{k_1} most freq els from #{nums_1} are #{output_1}"
  : "❌fails - result is #{output_1} but should be #{result_1}"

# Example 2:
nums_2 = [1]
k_2 = 1
result_2 = [1]
output_2 = k_most_freq_els(nums_2, k_2)
puts output_2 == result_2 ? "✅passes - #{k_2} most freq els from #{nums_2} are #{output_2}"
  : "❌fails - result is #{output_2} but should be #{result_2}"

# Example 3:
nums_3 = [1,2,1,2,1,2,3,1,3,2]
k_3 = 2
result_3 = [1,2]
output_3 = k_most_freq_els(nums_3, k_3)
puts output_3 == result_3 ? "✅passes - #{k_3} most freq els from #{nums_3} are #{output_3}"
  : "❌fails - result is #{output_3} but should be #{result_3}"