# Given a string paragraph and a string array of the banned words banned, return the most frequent word that is not banned.
# It is guaranteed there is at least one word that is not banned, and that the answer is unique.
# The words in paragraph are case-insensitive and the answer should be returned in lowercase.
# Note that words can not contain punctuation symbols.

# Constraints:
# 1 <= paragraph.length <= 1000
# paragraph consists of English letters, space ' ', or one of the symbols: "!?',;.".
# 0 <= banned.length <= 100
# 1 <= banned[i].length <= 10
# banned[i] consists of only lowercase English letters.

def most_common_word(paragraph, banned)
  word_map = Hash.new(0)
  
  paragraph.split(/[[:space:]!?',;.]+/).each do |word|
    # normd_word = word.downcase.delete("!?',;.")
    normd_word = word.downcase.gsub(/[!?',;.]/, '')

    word_map[normd_word] += 1
  end

  banned.each { |word| word_map[word] = 0 }

  word_map.sort_by { |k, v| -v }[0][0]
end

# Example 1:
para_1 = "Bob hit a ball, the hit BALL flew far after it was hit."
banned_1 = ["hit"]
answer_1 = "ball"
output_1 = most_common_word(para_1, banned_1)
puts output_1 == answer_1 ? "✅yes most common non banned word is #{output_1}" : "❌ no, most common non banned word is '#{answer_1}' not '#{output_1}'"
# Explanation: 
# "hit" occurs 3 times, but it is a banned word.
# "ball" occurs twice (and no other word does), so it is the most frequent non-banned word in the paragraph. 
# Note that words in the paragraph are not case sensitive,
# that punctuation is ignored (even if adjacent to words, such as "ball,"), 
# and that "hit" isn't the answer even though it occurs more because it is banned.

# Example 2:
para_2 = "a."
banned_2 = []
answer_2 = "a"
output_2 = most_common_word(para_2, banned_2)
puts output_2 == answer_2 ? "✅yes most common non banned word is #{output_2}" : "❌ no, most common non banned word is '#{answer_2}' not '#{output_2}'"
 
