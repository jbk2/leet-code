# Given an array of integers nums and an integer k, return the total number of subarrays whose sum equals to k.
# A subarray is a contiguous non-empty sequence of elements within an array.
# Constraints:
# 1 <= nums.length <= 2 * 104
# -1000 <= nums[i] <= 1000
# -107 <= k <= 107


def subarray_sum(arr, k)
  count = 0
  running_prefix = 0
  prefix_count = Hash.new(0)
  # base case so that the algo can calc L - 1 at first index 0
  prefix_count[0] = 1

  arr.each do |num|
    running_prefix += num
    # prefix[R] - prefix[L-1] = sum(L..R), we want the sum(L..R) which equals k, i.e. prefix[R] - prefix[L - 1] = k,
    # convert the formula to prefix[R] = k + prefix[L - 1], then to prefix[R] - k = prefix[L - 1], then sap sides to finally
    # prefix[L - 1] = prefix[R] - k, so we want to find how many previous examples there were of runnning prefixes which equal
    # running prefix - k, aka prefix[R] - k
    seeking_prefix = running_prefix - k
    count += prefix_count[seeking_prefix]
    # each running prefix gets counted in the prefix_count
    prefix_count[running_prefix] += 1
  end
  count
end

  # arr.each_with_index do |num, i|
  #   j = i - 1
  #   if i == 0
  #     prefixMap[i] = num
  #   else
  #     prefixMap[i] = num + prefixMap[j]  
  #   end
  # end
  
  # prefixMap
  
  # arr.each_with_index do |num, i|
  #   j = i + 1
  #   next if j > arr.length - 1
  
  #   while j < arr.length
  #     sum = num + arr[j]
  #     count += 1 if sum == k
  #     j += 1
  #   end
  # end

  # count

 

# Example 1:
nums_1 = [1,1,1]
k_1 = 2
answer_1 = 2
output_1 = subarray_sum(nums_1, k_1)
puts output_1 == answer_1 ? "✅ correct there were #{output_1} subarray sums of k value; #{k_1}" : "❌ incorrect - #{answer_1} subarrays sum to #{k_1}, not your output of #{output_1}"

# Example 2:
nums_2 = [1,2,3]
k_2 = 3
answer_2 = 2
output_2 = subarray_sum(nums_2, k_2)
puts output_2 == answer_2 ? "✅ correct there were #{output_2} subarray sums of k value; #{k_2}" : "❌ incorrect - #{answer_2} subarrays sum to #{k_2}, not your output of #{output_2}"
 

