require 'pry'
# @param {Integer[]} nums
# @return {Integer}

def length_of_lis(nums)
  return 0 if nums.empty?
  longest_subs = {}
  longest_subs[nums.length - 1] = 1

  calc_longest_sub = lambda do |nums, index|
    return longest_subs[index] if longest_subs[index]
    return 1 if nums.length == 1

    vals = [1]
    local_index = 1
    prev = nums[local_index - 1]

    (nums.length - 1).times do
      if prev < nums[local_index]
        vals << 1 + longest_subs[index + local_index]
      else
        vals << 1
      end

      local_index += 1
    end

    vals.max
  end

  index = nums.length - 1

  until index < 0 do
    longest_subs[index] = calc_longest_sub.call(nums[index..-1], index)
    index -= 1
  end

  max_vals = []

  longest_subs.keys.each do |key|
    max_vals << longest_subs[key]
  end

  # binding.pry
  max_vals.max
end

# Example 1:
nums1 = [10, 9, 2, 5, 3, 7, 101, 18]
# Output: 4
# Explanation: The longest increasing subsequence is [2,3,7,101], therefore the length is 4.

# Example 2:
nums2 = [0,1,0,3,2,3]
# Output: 4

# Example 3:
nums3 = [7,7,7,7,7,7,7]
# Output: 1
# 

# puts length_of_lis(nums)
puts length_of_lis(nums1) == 4 ? "correct for input #{nums1}" : "incorrect for input #{nums1}"
puts length_of_lis(nums2) == 4 ? "correct for input #{nums2}" : "incorrect for input #{nums2}"
puts length_of_lis(nums3) == 1 ? "correct for input #{nums3}" : "incorrect for input #{nums3}"