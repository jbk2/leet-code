# Given two integer arrays nums1 and nums2, return an array of their intersection. Each element in the result must appear as many times as it shows
# in both arrays and you may return the result in any order.
# Constraints:
# 1 <= nums1.length, nums2.length <= 1000
# 0 <= nums1[i], nums2[i] <= 1000


def intersection(a1, a2)
  counts = Hash.new { |h, k| h[k] = 0 }
  a1.each { |n| counts[n] += 1 }

  intersection = []
  a2.each do |n|
    if counts[n] == 0
      next
    else
      intersection << n
      counts[n] -= 1
    end
  end

  intersection  
end

# Example 1:
nums1 = [1,2,2,1]
nums2 = [2,2]
answer_1 = [2,2]
output_1 = intersection(nums1, nums2)
puts output_1 == answer_1 ? "✅ correct - intersections are #{output_1}" : "❌ incorrect, intersections shoudl be #{answer_1}, but you gave #{output_1}"

# Example 2:
nums2_1 = [4,9,5]
nums2_2 = [9,4,9,8,4]
answer_2 = [9,4]
output_2 = intersection(nums2_1, nums2_2)
puts output_2 == answer_2 ? "✅ correct - intersections are #{output_2}" : "❌ incorrect, intersections shoudl be #{answer_2}, but you gave #{output_2}"
# Explanation: [9,4] is also accepted.
 
