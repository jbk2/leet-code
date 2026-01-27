
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

# puts length_of_longest_substring(s1).inspect

def longest_substring(string)
  longest = 0
  seen_char_posns = {}
  left = 0
  
  string.each_char.with_index do |char, right|
    
    if seen_char_posns.key?(char) && seen_char_posns[char] >= left
      left = seen_char_posns[char] + 1
    end

    seen_char_posns[char] = right
  
    longest = [longest, right - left + 1].max
  end

  longest
end

string1 = "abcabcbb"
answer1 = 3
string2 = "bbbbb"
answer2 = 1
string3 = "pwwkew"
answer3 = 3

test_1 = longest_substring(string1)
puts test_1 == answer1 ? "✅passes - logest substring is indeed; #{test_1} long"
  : "❌fails - your test result was #{test_1}, but answer should be #{answer1}"
  
test_2 = longest_substring(string2)
puts test_2 == answer2 ? "✅passes - logest substring is indeed; #{test_2} long"
  : "❌fails - your test result was #{test_2}, but answer should be #{answer2}"

test_3 = longest_substring(string3)
puts test_3 == answer3 ? "✅passes - logest substring is indeed; #{test_3} long"
  : "❌fails - your test result was #{test_3}, but answer should be #{answer3}"