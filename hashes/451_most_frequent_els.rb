# Given a string s, sort it in decreasing order based on the frequency of the characters. The frequency of a character is the number of times it appears in the string.
# Return the sorted string. If there are multiple answers, return any of them.


def freq_sort(string)
  freqs = Hash.new { |h, k| h[k] = 0 }
  final_str = ""
  string.chars.each { |char| freqs[char] += 1 }

  freqs.sort_by { |k, v| [-v, k] }.each do |l, n|
    final_str << l * n
  end

  final_str
end

def freq_sort2(string)
  string.chars.tally.sort_by {|k, v| [-v, k] }.map{ |k, v| k * v}.join
end

# Example 1:
input_1 = "tree"
answer_1 = "eert"
output_1 = freq_sort2(input_1)
puts output_1 == answer_1 ? "✅ correct - sorted order is #{output_1}" : "❌ incorrect - sorted order should be #{answer_1}, not #{output_1}"
# Explanation: 'e' appears twice while 'r' and 't' both appear once.
# So 'e' must appear before both 'r' and 't'. Therefore "eetr" is also a valid answer.

# Example 2:
input_2 = "cccaaa"
answer_2 = "aaaccc"
output_2 = freq_sort(input_2)
puts output_2 == answer_2 ? "✅ correct - sorted order is #{output_2}" : "❌ incorrect - sorted order should be #{answer_2}, not #{output_2}"
# Explanation: Both 'c' and 'a' appear three times, so both "cccaaa" and "aaaccc" are valid answers.
# Note that "cacaca" is incorrect, as the same characters must be together.

# Example 3:
input_3 = "Aabb"
answer_3 = "bbAa"
output_3 = freq_sort(input_3)
puts output_3 == answer_3 ? "✅ correct - sorted order is #{output_3}" : "❌ incorrect - sorted order should be #{answer_3}, not #{output_3}"
# Explanation: "bbaA" is also a valid answer, but "Aabb" is incorrect.
# Note that 'A' and 'a' are treated as two different characters.


# Constraints:

# 1 <= s.length <= 5 * 105
# s consists of uppercase and lowercase English letters and digits.