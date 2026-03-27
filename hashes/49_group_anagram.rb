# Given an array of strings strs, group the anagrams together. You can return the answer in any order.
# Constraints:
  # 1 <= strs.length <= 104
  # 0 <= strs[i].length <= 100
  # strs[i] consists of lowercase English letters.

def grouped_anagrams(strings)
  anagrams = Hash.new { |h, k| h[k] = [] }
  groups = []

  strings.each_with_index do |string, i|
    anagrams[string.chars.sort.join] << i
  end
  
  anagrams.each do |sorted_str, indexes|
    group = []
    indexes.each { |i| group << strings[i] } 
    groups << group
  end

  groups.sort_by(&:length)
end



# Example 1:
input_1 = ["eat","tea","tan","ate","nat","bat"]
answer_1 = [["bat"], ["tan", "nat"], ["eat", "tea", "ate"]]
output_1 = grouped_anagrams(input_1)
puts output_1 == answer_1 ? "✅ correct, grouped anagrams are; #{output_1}" : "❌ incorrect - grouped anagrams should be; #{answer_1} not; #{output_1}"
# Explanation:
# There is no string in strs that can be rearranged to form "bat".
# The strings "nat" and "tan" are anagrams as they can be rearranged to form each other.
# The strings "ate", "eat", and "tea" are anagrams as they can be rearranged to form each other.

# Example 2:
input_2 = [""]
answer_2 = [[""]]
output_2 = grouped_anagrams(input_2)
puts output_2 == answer_2 ? "✅ correct, grouped anagrams are; #{output_2}" : "❌ incorrect - grouped anagrams should be; #{answer_2} not; #{output_2}"

# Example 3:
input_3 = ["a"]
answer_3 = [["a"]]
output_3 = grouped_anagrams(input_3)
puts output_3 == answer_3 ? "✅ correct, grouped anagrams are; #{output_3}" : "❌ incorrect - grouped anagrams should be; #{answer_3} not; #{output_3}"

 
