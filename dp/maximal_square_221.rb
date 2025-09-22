# @param {Character[][]} matrix
# @return {Integer}

# Brute force solution 
def maximal_square(matrix)
  rows = matrix.length
  columns = matrix[0].length
  max_area = 0

  all_area_ones = lambda do |start_row, end_row, start_col, end_col|
    (start_row..end_row).each { |row| return false if matrix[row][end_col] == '0' }
    (start_col..end_col).each { |col| return false if matrix[end_row][col] == '0' }
    true
  end

  (0..(rows - 1)).each do |start_row|
    (0..(columns - 1)).each do |start_col|
      next if matrix[start_row][start_col] == '0'

      end_row = start_row
      end_col = start_col

      side = 1
      max_area = [max_area, side * side].max

      while (end_row + 1) < rows &&
            (end_col + 1) < columns &&
            all_area_ones.call(start_row, end_row + 1, start_col, end_col + 1) == true
        end_row += 1
        end_col += 1
        side += 1
        max_area = [max_area, side * side].max
      end
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

