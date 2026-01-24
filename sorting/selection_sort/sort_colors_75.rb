# Given an array nums with n objects colored red, white, or blue, sort them in-place so
# that objects of the same color are adjacent, with the colors in the order red, white, and blue.
# We will use the integers 0, 1, and 2 to represent the color red, white, and blue, respectively.
# You must solve this problem without using the library's sort function.

def selection_sort(nums)
  (nums.length - 1).times do |idx|
    remainder_min_idx = min_index_from(nums, idx)

    if nums[remainder_min_idx] < nums[idx]
      nums[idx], nums[remainder_min_idx] = nums[remainder_min_idx], nums[idx]
    end 

  end
  nums
end

def min_index_from(nums, start_idx)
  min_idx = start_idx
  
  (start_idx + 1...nums.length).each do |idx|
    min_idx = idx if nums[min_idx] > nums[idx]
  end
  
  min_idx
end

def smallest(nums_arr)
  smallest = Float::INFINITY
  smallest_idx = nil
  
  nums_arr.each_with_index do |num, idx|
    if num < smallest
      smallest = num
      smallest_idx = idx
    end
  end 

  smallest_idx
end

# Example 1:
nums_1 = [2,0,2,1,1,0]
result_1 = [0,0,1,1,2,2]
# puts smallest(nums_1)
output_1 = selection_sort(nums_1)
# puts output_1.inspect
puts output_1 == result_1 ? "✅passes - with the correct sorted values; #{output_1}"
  : "❌fails - output is #{output_1}, but shoudl be #{result_1}"

# Example 2:
nums_2 = [2,0,1]
result_2 = [0,1,2]
output_2 = selection_sort(nums_2)
puts output_2 == result_2 ? "✅passes - with the correct sorted values; #{output_2}"
  : "❌fails - output is #{output_2}, but shoudl be #{result_2}"
# Constraints:
# n == nums.length
# 1 <= n <= 300
# nums[i] is either 0, 1, or 2.