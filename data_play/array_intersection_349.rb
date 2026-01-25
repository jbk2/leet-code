# Given two integer arrays nums1 and nums2, return an array of their intersection. Each element in the result must be unique
# and you may return the result in any order.

def intersection_easy(arr1, arr2)
  arr1.intersection1(arr2)
end

def intersection(arr1, arr2)
  intersections = []
  
  arr1.each do |el1|
    arr2.each do |el2|
      intersections << el1 if el1 == el2
    end
  end

  intersections.uniq
end

def intersection2(arr1, arr2)
  bubble_sort(arr1)
  bubble_sort(arr2)
  
  same = ->(a, b) { a == b }
  commons = Set.new
  i1, i2 = 0, 0

  while i1 < arr1.length && i2 < arr2.length
    if arr1[i1] == arr2[i2]
      commons.add(arr1[i1])
      i1 += 1; i2 += 1
    elsif arr1[i1] < arr2[i2]
      i1 += 1
    else
      i2 += 1
    end
  end

  commons.to_a
end

def bubble_sort(arr)
  loop do
    all_sorted = true

    (arr.length - 1).times do |idx|
      # while arr[idx + 1]
      if arr[idx] <= arr[idx + 1]
        next
      else
        all_sorted = false
        arr[idx], arr[idx + 1] = arr[idx + 1], arr[idx]
      end
    end
    break if all_sorted
  end
  arr
end


# Example 1:
nums1a = [1,2,2,1]
nums1b = [2,2]
result_1 = [2]

output_1 = intersection2(nums1a, nums1b)
puts output_1 == result_1 ? "✅passes - intersection vals are #{output_1}"
  : "❌fails - result is #{output_1}, but should be #{result_1}"

# Example 2:
nums2a = [4,9,5]
nums2b = [9,4,9,8,4]
result_2 = [4,9]
# Explanation: [4,9] is also accepted.

output_2 = intersection2(nums2a, nums2b)
puts output_2 == result_2 ? "✅passes - intersection vals are #{output_2}"
  : "❌fails - result is #{output_2}, but should be #{result_2}"

# Constraints:
# 1 <= nums1.length, nums2.length <= 1000
# 0 <= nums1[i], nums2[i] <= 1000