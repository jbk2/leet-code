# @param {Integer} num_rows
# @return {Integer[][]}
def generate(num_rows)
  return nil if num_rows.nil?
  # return 1 if num_rows == 1
  memo = {}

  val = lambda do |r, c|
    return 1 if r == 0 || c == 0 || r == c

    memo[[r, c]] ||= val.call(r - 1, c - 1) + val.call(r - 1, c)
  end

  rows = cols = num_rows
  row_index = 0
  triangle = []

  while row_index < rows do
    row_arr = []
    col_index = 0

    while col_index <= row_index do
      row_arr << val.call(row_index, col_index)
      col_index += 1
    end

    triangle << row_arr
    row_index += 1
  end

  triangle
end

one_row = generate(23)
puts one_row.inspect