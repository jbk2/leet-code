s1 = "abcabcbb"
s2 = "bbbbb"
s3 = "pwwkew"

def length_of_longest_substring(string)
return 0 if string.empty?

  longest_subs = [string[0]]

  string.chars.each_cons(2) do |a, b|
    if longest_subs[-1].include?(b)
      index = longest_subs[-1].index(b) + 1
      new_sub = longest_subs[-1][index..-1] + b
      longest_subs << new_sub
    else
      longest_subs[-1] << b
    end

  end
  
  longest_sub = longest_subs.map(&:length).max
end

puts length_of_longest_substring(s1).inspect