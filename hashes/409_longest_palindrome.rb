# Given a string s which consists of lowercase or uppercase letters, return the length of the longest palindrome that can be built with those letters.
# Letters are case sensitive, for example, "Aa" is not considered a palindrome.
 
# Constraints:
  # 1 <= s.length <= 2000
  # s consists of lowercase and/or uppercase English letters only.

def longest_palindrome_length(input)
  counts = input.chars.tally
  length = counts.values.sum { |v| v.even? ? v : v - 1 }
  length += 1 if counts.values.any?(&:odd?)
  length
end

# Example 1:
input_1 = "abccccdd"
answer_1 = 7
output_1 = longest_palindrome_length(input_1)
puts output_1 == answer_1 ? "✅ correct, longest palidrome is #{output_1}" : "❌ incorrect - longest palindrome is; #{answer_1}, not; #{output_1}"

# Explanation: One longest palindrome that can be built is "dccaccd", whose length is 7.

# Example 2:
input_2 = "a"
answer_2 = 1
output_2 = longest_palindrome_length(input_2)
puts output_2 == answer_2 ? "✅ correct, longest palidrome is #{output_2}" : "❌ incorrect - longest palindrome is; #{answer_2}, not; #{output_2}"
# Explanation: The longest palindrome that can be built is "a", whose length is 1.
 