# A sentence is a string of single-space separated words where each word consists only of lowercase letters.
# A word is uncommon if it appears exactly once in one of the sentences, and does not appear in the other sentence.
# Given two sentences s1 and s2, return a list of all the uncommon words. You may return the answer in any order.

# Constraints:
# 1 <= s1.length, s2.length <= 200
# s1 and s2 consist of lowercase English letters and spaces.
# s1 and s2 do not have leading or trailing spaces.
# All the words in s1 and s2 are separated by a single space.

def uncommon(s1, s2)
  map = Hash.new { |h, k| h[k] = 0 }
  (s1 + ' ' + s2).split(' ').each { |w| map[w] += 1 }
  map.select { |_, v| v == 1 }.keys
end

# Example 1:
s_1_1 = "this apple is sweet"
s_1_2 = "this apple is sour"
answer_1 = ["sweet","sour"]
output_1 = uncommon(s_1_1, s_1_2)
# Explanation:
# The word "sweet" appears only in s1, while the word "sour" appears only in s2.
puts output_1 == answer_1 ? "✅ correct - uncommon words were #{output_1}" : "❌ incorrect - uncommon words are #{answer_1}, but you gave #{output_1}"

# Example 2:
s_2_1 = "apple apple"
s_2_2 = "banana"
answer_2 = ["banana"]
output_2 = uncommon(s_2_1, s_2_2)
puts output_2 == answer_2 ? "✅ correct - uncommon words were #{output_2}" : "❌ incorrect - uncommon words are #{answer_2}, but you gave #{output_2}"

 
