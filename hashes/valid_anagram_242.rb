# Given two strings s and t, return true if t is an anagram of s, and false otherwise.
# Constraints:
# 1 <= s.length, t.length <= 5 * 104
# s and t consist of lowercase English letters.

def anagram?(s, t)
  return false if s.length != t.length
  s_map = {}
  t_map = {}

  create_map = lambda do |map, string|
    string.each_char do |char|
      if map[char]
        map[char] += 1
      else
        map[char] = 1
      end
    end
  end

  create_map.call(s_map, s)
  create_map.call(t_map, t)

  s_map.keys.each do |key|
    return false if t_map[key] != s_map[key]
  end

  return true
end

def anagram_2?(s, t)
  return false if s.length != t.length

  char_arr = Array.new(26, 0)

  s.each_char do |char|
    letter_idx = char.ord - "a".ord
    char_arr[letter_idx] += 1
  end

  t.each_char do |char|
    letter_idx = char.ord - "a".ord 
    char_arr[letter_idx] -= 1
    return false if char_arr[letter_idx] < 0
  end
  return true
end

# Time complexity: O(n)
# Space complexity: O(1)

# Example 1:
s_1 = "anagram"
t_1 = "nagaram"
answer_1 = true
output_1 = anagram_2?(s_1, t_1)
puts output_1 == answer_1 ? "✅passes - correctly identifies that is #{ output_1 ? "is" : "is not"} an anagram"
  : "❌fails - output says #{output_1 ? "is" : "is not"}, but should #{ answer_1 ? "be" : "not be"} an anagram"

# Example 2:
s_2 = "rat"
t_2 = "car"
answer_2 = false
output_2 = anagram_2?(s_2, t_2)
puts output_2 == answer_2 ? "✅passes - correctly identifies that is #{ output_2 ? "is" : "is not"} an anagram"
  : "❌fails - output says #{output_2 ? "is" : "is not"}, but should #{ answer_2 ? "be" : "not be"} an anagram"
 
# Example 3:
s_3 = "ab"
t_3 = "a"
answer_3 = false
output_3 = anagram_2?(s_3, t_3)
puts output_3 == answer_3 ? "✅passes - correctly identifies that is #{ output_3 ? "is" : "is not"} an anagram"
  : "❌fails - output says #{output_3 ? "is" : "is not"}, but should #{ answer_3 ? "be" : "not be"} an anagram"
 
# Follow up: What if the inputs contain Unicode characters? How would you adapt your solution to such a case?

