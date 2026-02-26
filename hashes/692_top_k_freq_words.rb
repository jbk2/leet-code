# Given an array of strings words and an integer k, return the k most frequent strings.
# Return the answer sorted by the frequency from highest to lowest. Sort the words with the same frequency by their lexicographical order.
# Constraints:
# 1 <= words.length <= 500
# 1 <= words[i].length <= 10
# words[i] consists of lowercase English letters.
# k is in the range [1, The number of unique words[i]]

def top_k_freq_words(words, k)
  map = Hash.new { |h,k| h[k] = 0 }
  words.each { |w| map[w] += 1 }
  map
    .sort_by{ |word, count| [-count, word] }
    .first(k)
    .map(&:first)
end


# Example 1:
words_1 = ["i","love","leetcode","i","love","coding"]
k_1 = 2
answer_1 = ["i","love"]
output_1 = top_k_freq_words(words_1, k_1)
puts output_1 == answer_1 ? "✅ correct - #{k_1} most frequent words, in desc frequency order are #{output_1}"
  : "❌ incorrect - #{k_1} most frequent words were #{answer_1}, but you gave #{output_1}"
# Explanation: "i" and "love" are the two most frequent words.
# Note that "i" comes before "love" due to a lower alphabetical order.

# Example 2:
words_2 = ["the","day","is","sunny","the","the","the","sunny","is","is"]
k_2 = 4
answer_2 = ["the","is","sunny","day"]
output_2 = top_k_freq_words(words_2, k_2)
puts output_2 == answer_2 ? "✅ correct - #{k_2} most frequent words, in desc frequency order are #{output_2}"
  : "❌ incorrect - #{k_2} most frequent words were #{answer_2}, but you gave #{output_2}"
# Explanation: "the", "is", "sunny" and "day" are the four most frequent words, with the number of occurrence being 4, 3, 2 and 1 respectively.
 

 