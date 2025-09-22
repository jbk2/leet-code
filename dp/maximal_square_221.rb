# @param {Character[][]} matrix
# @return {Integer}

# Brute force solution
# (The pattern is that a larger square is just the addition of two new edges connected to/ending in the diagonal element in the direction of square growth)
# def maximal_square(matrix)
#   rows = matrix.length
#   columns = matrix[0].length
#   max_area = 0

#   new_edges_all_ones = lambda do |start_row, end_row, start_col, end_col|
#     (start_row..end_row).each { |row| return false if matrix[row][end_col] == '0' }
#     (start_col..(end_col - 1)).each { |col| return false if matrix[end_row][col] == '0' }
#     true
#   end

#   (0..(rows - 1)).each do |start_row|
#     (0..(columns - 1)).each do |start_col|
#       next if matrix[start_row][start_col] == '0'

#       end_row = start_row
#       end_col = start_col

#       side = 1
#       max_area = [max_area, side * side].max

#       while (end_row + 1) < rows &&
#             (end_col + 1) < columns &&
#             new_edges_all_ones.call(start_row, end_row + 1, start_col, end_col + 1) == true
#         end_row += 1
#         end_col += 1
#         side += 1
#         max_area = [max_area, side * side].max
#       end
#     end
#   end
#   max_area
# end

# Bottom up DP approach
# Explanation:
# - 2d grid to house results, 1 longer than matrix rows & cols so that the algorithm can 00 visit the base case cells in the row and col before
# - iterate through results grid left>right top>bottom, checking corresponding matrix value, if 1 then set current value as sum of current 1 and
#   the min value alredy recorded in preceeding -1 results cells.
#  - 
# (The pattern is create a results 2d array graph, with one extra row and col, run an algorithm which iterates up the rows and cols from 1 to matrix length,
# checking whether the matrix' equiv -1 value, if it's 1 then check prev up, left and diagonal are all 1s, if so then set current to sum of 1 and previous'
# x3 cell's value (they'll all be the same), then set max_area counter if current is larger. Iterate through all cells building up the max_area counts one by one.
# their value to
# check )
# def maximal_square(matrix)
#   rows = matrix.length
#   cols = matrix[0].length
#   maximums = Array.new(rows + 1) { Array.new(cols + 1, 0) }
#   max_area = 0

#   (1..rows).each do |row|
#     (1..cols).each do |col|
#       if matrix[row - 1][col - 1] == '1'
#         maximums[row][col] =
#         1 + [
#           maximums[row - 1][col - 1],
#           maximums[row][col - 1],
#           maximums[row - 1][col]
#         ].min
#       end

#       side = maximums[row][col]
#       max_area = [max_area, side * side].max
#     end
#   end

#   max_area
# end

# Top down DP approach
# Intuitie explanation:
# - create a 2d memo, with 1 row and col extra at beginning to allow algo to inspect current-1 cell
# - create helper/lambda with base case of 0 if in first row or col
# - within helper check for current corresponding matrix value, if 1 then sum that 1 and the min of recursive helper
#   fn calls to the previous neighbouring left, left up, and up cells.
# - so lambda essentially returns the max side value for the given coordinate its called with
#  - store those lambda call results in 2d memo at given coords
# - iterate accross and down calling lambda for each cell, returning memo if there is one if not calling lambda,
#   and update max_area with side **2 if it;s larger, then return max_area when everything else is done.
def maximal_square(matrix)
  rows = matrix.length
  cols = matrix[0].length
  memo = Array.new(rows + 1) { Array.new(cols + 1) }
  max_area = 0

  largest_side = lambda do |row, col|
    return 0 if row == 0 || col == 0
    return memo[row][col] unless memo[row][col].nil?

    if matrix[row - 1][col - 1] == '1'
      memo[row][col] = 1 + [
        largest_side.call(row - 1, col - 1),
        largest_side.call(row - 1, col),
        largest_side.call(row, col - 1)
      ].min
    else
      memo[row][col] = 0
    end
  end
  
  (1..rows).each do |row|
    (1..cols).each do |col|
      side = largest_side.call(row, col)
      max_area = [max_area, side * side].max
    end
  end

  max_area
end

# Example 1:
matrix1 = [["1","0","1","0","0"],["1","0","1","1","1"],["1","1","1","1","1"],["1","0","0","1","0"]]
result1 = 4

# Example 2:
matrix2 = [["0","1"],["1","0"]]
result2 = 1

# Example 3:
matrix3 = [["0"]]
result3 = 0

test1 = maximal_square(matrix1)
test2 = maximal_square(matrix2)
test3 = maximal_square(matrix3)
puts test1 == result1 ? "✅passes, with matrix1;#{matrix1}, result = #{test1}" : "❌fails with with matrix1 #{matrix1}, result = #{test1}"
puts test2 == result2 ? "✅passes, with matrix2;#{matrix2}, result = #{test2}" : "❌fails with with matrix2 #{matrix2}, result = #{test2}"
puts test3 == result3 ? "✅passes, with matrix3;#{matrix3}, result = #{test3}" : "❌fails with with matrix3 #{matrix3}, result = #{test3}"

