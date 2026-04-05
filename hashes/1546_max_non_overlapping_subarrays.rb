# Given an array nums and an integer target, return the maximum number of non-empty non-overlapping subarrays
# such that the sum of values in each subarray is equal to target.

# Constraints:
# 1 <= nums.length <= 105
# -104 <= nums[i] <= 104
# 0 <= target <= 106
 
def max_no_non_overlapping_array(array, target)
  
end




RSpec.describe do
  describe ":max_no_non_overlapping_array(nums, target)" do    
    # Explanation: There are 2 non-overlapping subarrays [1,1,1,1,1] with sum equals to target(2).
    it "test 1 returns the correct result" do
      nums_1 = [1,1,1,1,1]
      target_1 = 2
      answer_1 = 2
      output_1 = max_no_non_overlapping_array(nums_1, target_1)
      expect(output_1).to eq(answer_1)
    end
    
    # Explanation: There are 3 subarrays with sum equal to 6.
    # ([5,1], [4,2], [3,5,1,4,2,-9]) but only the first 2 are non-overlapping.
    it "test 2 returns the correct result" do
      nums_2 = [-1,3,5,1,4,2,-9]
      target_2 = 6
      answer_2 = 2
      output_2 = max_no_non_overlapping_array(nums_2, target_2)
      expect(output_1).to eq(answer_1)
    end
  end
end
