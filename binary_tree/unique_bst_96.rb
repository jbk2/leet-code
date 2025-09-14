def num_trees(n)
# how to define structural uniqueness?
# define patterns maybe? - a marker for last designed node:
# last created node was a left, so next one must be opposite == a right
# whats the pattern?
# flattest = each level is previous level * 2? until number of nodes = n of > n
# deepest = n
# solution count = 0
# return solution if n == 0
# return 1 if n == 1
# shape options, if more than 1 node;
# - always all left, or all right,
# - then one right all other left, one left all others right,
# - then alternate left to right
# 
# - maybe transferring to binary and alterative patterns
# - key is how many options = 2, then how many nodes n, so it's n ^ 2 isn't it?
end