# A school is trying to take an annual photo of all the students. The students are asked to stand in a single file line in non-decreasing order by height.
# Let this ordering be represented by the integer array expected where expected[i] is the expected height of the ith student in line.
# You are given an integer array heights representing the current order that the students are standing in. Each heights[i] is the height of the ith student in line (0-indexed).
# Return the number of indices where heights[i] != expected[i].

def height_checker(heights)
  orig_heights = heights.dup
  sorted = bubble_sort_2(heights)  
  malorder_count = 0

  orig_heights.length.times do |idx|
    malorder_count += 1 if orig_heights[idx] != sorted[idx]
  end 

  malorder_count
end

def bubble_sort(arr)
  length = arr.length
  last_idx = length - 1 
  
  length.times do
    sorted = true

    arr.each_with_index do |_, idx|
      next if idx >= last_idx
      
      if arr[idx] > arr[idx + 1]
        sorted = false
        arr[idx], arr[idx + 1] = arr[idx + 1], arr[idx]
      end

    end
    last_idx -= 1
    break if sorted
  end
  arr
end

def bubble_sort_2(input)
  
  input.length.times do |n|
    all_sorted = true

    (0...(input.length - 1 - n)).each do |left_idx|
      left_val = input[left_idx]
      neighbour_idx = left_idx + 1
      neighbour_val = input[neighbour_idx]
      
      if left_val > neighbour_val
        all_sorted = false
        input[left_idx], input[neighbour_idx] = input[neighbour_idx], input[left_idx]
      end
    end
    
    break if all_sorted
  end
  input
end
  
 

# Example 1:
heights_1 = [1,1,4,2,1,3]
result_1 = 3
# puts bubble_sort_2(heights_1).inspect
output_1 = height_checker(heights_1)
puts output_1 == result_1 ? "✅passes - there are #{output_1} out of order values"
  : "❌fails - result is #{output_1}, but there are actually #{result_1} out of order values"
# Explanation: 
# heights:  [1,1,4,2,1,3]
# expected: [1,1,1,2,3,4]
# Indices 2, 4, and 5 do not match.

# Example 2:
heights_2 = [5,1,2,3,4]
result_2 = 5
output_2 = height_checker(heights_2)
puts output_2 == result_2 ? "✅passes - there are #{output_2} out of order values"
  : "❌fails - result is #{output_2}, but there are actually #{result_2} out of order values"
# Explanation:
# heights:  [5,1,2,3,4]
# expected: [1,2,3,4,5]
# All indices do not match.

# Example 3:
heights_3 = [1,2,3,4,5]
result_3 = 0
output_3 = height_checker(heights_3)
puts output_3 == result_3 ? "✅passes - there are #{output_3} out of order values"
  : "❌fails - result is #{output_3}, but there are actually #{result_3} out of order values"
# Explanation:
# heights:  [1,2,3,4,5]
# expected: [1,2,3,4,5]
# All indices match.
 

# Constraints:

# 1 <= heights.length <= 100
# 1 <= heights[i] <= 100