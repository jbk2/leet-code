# A phrase is a palindrome if, after converting all uppercase letters into lowercase letters and removing all non-alphanumeric characters, it reads the same forward and backward. Alphanumeric characters include letters and numbers.
# Given a string s, return true if it is a palindrome, or false otherwise.
# Constraints:
# 1 <= s.length <= 2 * 105
# s consists only of printable ASCII characters.

def valid_palindrome(string)
  l_idx = 0
  r_idx = string.length - 1
  alpha_num = /[a-zA-Z0-9]/
  
  while l_idx < r_idx
    l_idx += 1 while !string[l_idx].match?(alpha_num)
    r_idx -= 1 while !string[r_idx].match?(alpha_num)
    
    return false if string[l_idx].downcase != string[r_idx].downcase
     l_idx += 1
     r_idx -= 1
  end
  true
end


# Example 1:
input_1 = "A man, a plan, a canal: Panama"
result_1 = true
# Explanation: "amanaplanacanalpanama" is a palindrome.
test_1 = valid_palindrome(input_1)
puts test_1 == result_1 ? "✅passes - is #{input_1} a palindrome? - #{test_1}" : "❌fails - is #{input_1} a palindrime? - #{test_1}"

# Example 2:
input_2 = "race a car"
result_2 = false
# Explanation: "raceacar" is not a palindrome.
test_2 = valid_palindrome(input_2)
puts test_2 == result_2 ? "✅passes - is #{input_2} a palindrome? - #{test_2}" : "❌fails - is #{input_2} a palindrime? - #{test_2}"

# Example 3:
input_3 = " "
result_3 = true
# Explanation: s is an empty string "" after removing non-alphanumeric characters.
# Since an empty string reads the same forward and backward, it is a palindrome.
test_3 = valid_palindrome(input_3)
puts test_3 == result_3 ? "✅passes - is #{input_3} a palindrome? - #{test_3}" : "❌fails - is #{input_3} a palindrime? - #{test_3}"
 

