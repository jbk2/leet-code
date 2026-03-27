# 2946. Matrix Similarity After Cyclic Shifts

# You are given an m x n integer matrix mat and an integer k. The matrix rows are 0-indexed.
# The following proccess happens k times:
# Even-indexed rows (0, 2, 4, ...) are cyclically shifted to the left.
# Odd-indexed rows (1, 3, 5, ...) are cyclically shifted to the right.
# Return true if the final modified matrix after k steps is identical to the original matrix, and false otherwise.

def shifted_matrix_same?(matrix, k)
  return true if k % matrix.first.length == 0

  matrix.each_with_index do |row, i|

    row.each_with_index do |el, i|
      shifted_idx = !i.even? ? (i - k) % row.length : (i + k) % row.length
      if el != row[shifted_idx]
        return false
      end
    end
  end

  true
end

# Example 1:
input_1 = [[1,2,3],[4,5,6],[7,8,9]]
k_1 = 4
answer_1 = false
output_1 = shifted_matrix_same?(input_1, k_1)
puts output_1 == answer_1 ? "✅ correct, shifted matrix is #{output_1 ? "is" : "is not" } the same" : "❌ incorrect - shifted matrix #{answer_1 ? "is" : "is not" } the same"
# Explanation:
# In each step left shift is applied to rows 0 and 2 (even indices), and right shift to row 1 (odd index).

# Example 2:
input_2 = [[1,2,1,2],[5,5,5,5],[6,3,6,3]]
k_2 = 2
answer_2 = true
output_2 = shifted_matrix_same?(input_2, k_2)
puts output_2 == answer_2 ? "✅ correct, shifted matrix is #{output_2 ? "is" : "is not" } the same" : "❌ incorrect - shifted matrix #{answer_2 ? "is" : "is not" } the same"

# Example 3:
input_3 = [[2,2],[2,2]]
k_3 = 3
answer_3 = true
output_3 = shifted_matrix_same?(input_3, k_3)
puts output_3 == answer_3 ? "✅ correct, shifted matrix is #{output_3 ? "is" : "is not" } the same" : "❌ incorrect - shifted matrix #{answer_3 ? "is" : "is not" } the same"

# Explanation:

# As all the values are equal in the matrix, even after performing cyclic shifts the matrix will remain the same.

 

# Constraints:

# 1 <= mat.length <= 25
# 1 <= mat[i].length <= 25
# 1 <= mat[i][j] <= 25
# 1 <= k <= 50