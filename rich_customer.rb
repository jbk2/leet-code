acc1 = [[1,2,3],[3,2,1]]
acc2 = [[1,5],[7,3],[3,5]]
acc3 = [[2,8,7],[7,1,3],[1,9,5]]

def maximum_wealth(accounts)
  accounts.map { |c| c.sum }.max
end

puts maximum_wealth(acc3)