# @param {Integer} row_index
# @return {Integer[]}

def get_row(row_index)
  return 1 if col == 0 || row = 0 || col == row

  get_row(row_index - 1)
  
end

