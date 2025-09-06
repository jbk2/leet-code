# @param {Character[]} s
# @return {Void} Do not return anything, modify s in-place instead.
def reverse_string(s)
  reverser(s, 0, s.length - 1)
  s
end

def reverser(s, l_ind, r_ind)
  s[l_ind], s[r_ind] = s[r_ind], s[l_ind]
  l_ind += 1
  r_ind -= 1
  reverser(s, l_ind, r_ind) unless l_ind >= r_ind
  
end
