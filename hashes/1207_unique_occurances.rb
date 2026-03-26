# Given an array of integers arr, return true if the number of occurrences of each value in the array is unique or false otherwise.
 
def unique_occurances(arr)
  # hash table occurrances, pull out occurance values, see if all are uniq
  occurances = Hash.new { |h, k| h[k] = 0 }
  arr.each { |int| occurances[int] += 1 }
  occurances.values.uniq.count == occurances.values.count
end

def unique_occurances?(arr)
  counts = arr.tally.values
  counts.length == counts.to_set.length
end

# Example 1:
input_1 = [1,2,2,1,1,3]
answer_1 = true
output_1 = unique_occurances?(input_1)
# Explanation: The value 1 has 3 occurrences, 2 has 2 and 3 has 1. No two values have the same number of occurrences.
puts output_1 == answer_1 ? "✅ correct"
  : "❌ incorrect - #{answer_1 ? "should return true, but you returned #{output_1}" : "should return false but you retuend #{output_1}"}"


# Example 2:
input_2 = [1,2]
answer_2 = false
output_2 = unique_occurances?(input_2)
puts output_2 == answer_2 ? "✅ correct"
  : "❌ incorrect - #{answer_2 ? "should return true, but you returned #{output_2}" : "should return false but you retuend #{output_2}"}"
  
# Example 3:
input_3 = [-3,0,1,-3,1,1,1,-3,10,0]
answer_3 = true
output_3 = unique_occurances?(input_3)
puts output_3 == answer_3 ? "✅ correct"
  : "❌ incorrect - #{answer_3 ? "should return true, but you returned #{output_1}" : "should return false but you retuend #{output_3}"}"