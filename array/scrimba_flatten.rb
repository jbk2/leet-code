def flatten_array(arr)
  newArr = []

  dfs = lambda do |el|
    if el.is_a?(Array)
      el.each {|e| dfs.call(e) }
    else
      newArr << el
    end
  end

  dfs.call(arr)

  return newArr
end

kittyScores = [
    [39, 99, 76], 89, 98, [87, 56, 90], 
    [96, 95], 40, 78, 50, [63]
];

kittyPrizes = [
    ["💰", "🐟", "🐟"], "🏆", "💐", "💵", ["💵", "🏆"],
    ["🐟","💐", "💐"], "💵", "💵", ["🐟"], "🐟"
];

puts flatten_array(kittyScores).inspect
puts flatten_array(kittyPrizes).inspect