// Example input: [1, [4,5], [4,7,6,4], 3, 5]
// Example output: [1, 4, 5, 4, 7, 6, 4, 3, 5]

const kittyScores = [
    [39, 99, 76], 89, 98, [87, 56, 90], 
    [96, 95], 40, 78, 50, [63]
];

const kittyPrizes = [
    ["💰", "🐟", "🐟"], "🏆", "💐", "💵", ["💵", "🏆"],
    ["🐟","💐", "💐"], "💵", "💵", ["🐟"], "🐟"
];

export function flatten(arr) {
  const newArr = []

  const dfs = (el) => {
    if(!Array.isArray(el)) {
      newArr.push(el);
      return
    }
    
    el.forEach((el) => {
        dfs(el);
    })
  };

  arr.forEach((el) => {
    dfs(el);
  });

  return newArr;
}

console.log(flatten(kittyScores));
console.log(flatten(kittyPrizes));