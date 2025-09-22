require 'pry'
# @param {String} text1
# @param {String} text2
# @return {Integer}
def longest_common_subsequence(text1, text2)
  t1l, t2l = text1.length, text2.length
  memo = Array.new(t1l) { Array.new(t2l) }

  count_lcs = lambda do |t1_index, t2_index|
    return 0 if t1_index == t1l || t2_index == t2l
    return memo[t1_index][t2_index] if memo[t1_index][t2_index]

    if text1[t1_index] == text2[t2_index]
      memo[t1_index][t2_index] = 1 + count_lcs.call(t1_index + 1, t2_index + 1)
    else
      memo[t1_index][t2_index] = [
        count_lcs.call(t1_index + 1, t2_index),
        count_lcs.call(t1_index, t2_index + 1)
      ].max
    end
  end

  count_lcs.call(0, 0)
end

# Example 1:
Eg1text1 = "abcde"
Eg1text2 = "ace" 
result1 = 3  
# Explanation: The longest common subsequence is "ace" and its length is 3.

# Example 2:
Eg2text1 = "abc"
Eg2text2 = "abc"
result2 = 3
# Explanation: The longest common subsequence is "abc" and its length is 3.

# Example 3:
Eg3text1 = "abc"
Eg3text2 = "def"
result3 = 0
# Explanation: There is no such common subsequence, so the result is 0.

test1 = longest_common_subsequence(Eg1text1, Eg1text2)
test2 = longest_common_subsequence(Eg2text1, Eg2text2)
test3 = longest_common_subsequence(Eg3text1, Eg3text2)
puts test1 == result1 ? "✅passes, with text1;#{Eg1text1} & text2;#{Eg1text2}, result = #{test1}" : "❌fails with with text1;#{Eg1text1} & text2;#{Eg1text2}, result = #{test1}"
puts test2 == result2 ? "✅passes, with text1;#{Eg2text1} & text2;#{Eg2text2}, result = #{test2}" : "❌fails with with text1;#{Eg2text1} & text2;#{Eg2text2}, result = #{test2}"
puts test3 == result3 ? "✅passes, with text1;#{Eg3text1} & text2;#{Eg3text2}, result = #{test3}" : "❌fails with with text1;#{Eg3text1} & text2;#{Eg3text2}, result = #{test3}"