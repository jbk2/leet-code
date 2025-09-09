# @param {Integer} num_rows
# @return {Integer[][]}
def generate(num_rows)
  return 1 if num_rows == 1 || 
  
  val = lambda do |r, c|
    return 1 if r = 0 || c = 0 || r == c
    val(r - 1, c - 1) + val(r - 1, c) 
  end

  rows, cols = num_rows
  rows = Array.new(rows, [])
  row = rows

  while row > 0 do
    row_arr = Array.new
    col = 0

    while col < cols do
      row_arr << val.call(row, col)
      col += 1
    end
    rows << row_arr
    row -= 1
  end

end