import { isPalindrome } from './palindrome';
import { describe, test, expect } from 'vitest'

describe(isPalindrome, () => {
  test("array of length 4 with 2 palindromes returns the correct 2 palindromes", () => {
    const usernames = ["Tricer66", "TREXerT", "Veloc1COLEv", "stego95"];
    const result = ["TREXerT", "Veloc1COLEv"];
    expect(isPalindrome(usernames)).toEqual(result);
  });

  test("array of length 2 with 0 palindromes returns an empty array", () => {
    const usernames = ["saurus111", "BRACHI33"];
    const result = [];
    expect(isPalindrome(usernames)).toEqual(result);
  });
});

// Test Examples:
// Example 1:

// Example 2:

// console.log(isPalindrome(usernames_1))
