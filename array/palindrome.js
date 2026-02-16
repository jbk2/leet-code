// In addition, in our algorithm, "Bob", and "zAAaaZ" are also palindromes since we are ignoring the letter case.

// Constraints:
// ************

// 1. usernames.length >= 0.
// 2. A username may only contain letters and digits but must start with a letter. The letters can be uppercase or lowercase.
// 3. username.length > 0.

function isPalindrome(array) {
  const palindromes = [];

  array.forEach((word) => {
    const string = word.toLowerCase();
    const length = word.length;
    const midIdx = Math.floor(length / 2);
    let allMatch = true;
    
    for (let i = 0; i < midIdx; i++) {
      const left = string[i], right = string[length - 1 - i];
      if (left != right) {
        allMatch = false;
        break;
      }
    }

    if (allMatch) palindromes.push(word);
  });
  return palindromes;
}

export { isPalindrome }