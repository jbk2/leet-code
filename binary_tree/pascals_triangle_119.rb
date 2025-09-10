# @param {Integer} row_index
# @return {Integer[]}

def get_row(row_index)
  row = []
  col_index = 0
  memo = {}

  get_number = lambda do |r, c|
    return 1 if r.zero? || c.zero? || r == c

    memo[[r, c]] ||= get_number.call(r - 1, c - 1) + get_number.call(r - 1, c)
  end

  until col_index > row_index do
    row << get_number.call(row_index, col_index)
    col_index += 1
  end

  row
end

puts get_row(5).inspect
