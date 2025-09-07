# @param {Character[]} s
# @return {Void} Do not return anything, modify s in-place instead.
def reverse_string(s)
  rec = -> (l, r) do
    s[l], s[r] = s[r], s[l]
  end

  l, r = 0, s.length - 1

  while l < r
    rec.call(l, r)
    l += 1
    r -= 1
  end

  s
end
