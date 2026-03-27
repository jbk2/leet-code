# Given a non-empty array of non-negative integers nums, the degree of this array is defined as the maximum frequency of any one of its elements.
# Your task is to find the smallest possible length of a (contiguous) subarray of nums, that has the same degree as nums.

def degree_matched_sub_array_length(arr)
  occurances = arr.tally
  max_occurance = occurances.max_by {|k, v| v}[1]
  max_occurance_vals = occurances.select { |k, v| v == max_occurance }
  min_length = Float::INFINITY

  max_occurance_vals.each do |value, occurance|
    first_i = arr.index(value)
    last_i = arr.rindex(value)
    length = (last_i - first_i) + 1
    min_length = [length, min_length].min
  end
  
  min_length
end

def degree_matched_sub_array_length2(arr)
  counts = Hash.new(0)
  left = Hash.new
  right = Hash.new
  
  arr.each_with_index do |num, i|
    left[num] ||= i
    right[num] = i
    counts[num] += 1
  end
  
  degree = counts.values.max
  shortest_sub_arr = arr.length
  
  counts.each do |val, count|
    next if count != degree
    shortest_sub_arr = [(right[val] - left[val] + 1), shortest_sub_arr].min
  end

  shortest_sub_arr
end



# Example 1:
input_1 = [1,2,2,3,1]
answer_1 = 2
output_1 = degree_matched_sub_array_length2(input_1)
puts output_1 == answer_1 ? "✅ correct, shortest degree matches contiguous subarray is #{output_1}"
  : "❌ incorrect - answer should be #{answer_1} not #{output_1}"
# Explanation: 
# The input array has a degree of 2 because both elements 1 and 2 appear twice.
# Of the subarrays that have the same degree:
# [1, 2, 2, 3, 1], [1, 2, 2, 3], [2, 2, 3, 1], [1, 2, 2], [2, 2, 3], [2, 2]
# The shortest length is 2. So return 2.

# Example 2:
input_2 = [1,2,2,3,1,4,2]
answer_2 = 6
output_2 = degree_matched_sub_array_length2(input_2)
puts output_2 == answer_2 ? "✅ correct, shortest degree matches contiguous subarray is #{output_2}"
  : "❌ incorrect - answer should be #{answer_2} not #{output_2}"
# Explanation: 
# The degree is 3 because the element 2 is repeated 3 times.
# So [2,2,3,1,4,2] is the shortest subarray, therefore returning 6.


# Constraints:
# nums.length will be between 1 and 50,000.
# nums[i] will be an integer between 0 and 49,999.