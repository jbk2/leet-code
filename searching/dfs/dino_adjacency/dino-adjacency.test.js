import areTheyConnected from './dino-connection';
import { describe, test, expect } from 'vitest';

describe('areTheyConnected function', () => {
  test('given a 9 long adjacency list and a connected vertices', () => {
    const dinos1 = [0, 4]
    const adjacency1 = [[1, 2], [0, 3], [0, 3, 4], [1, 2], [2], [6], [5, 7], [6, 8], [7]]
    const answer1 = true
    expect(areTheyConnected(dinos1, adjacency1)).toEqual(answer1);
  });
  
  test('given a 9 long adjacency list and non connected vertices', () => {
    const dinos2 = [0, 7]
    const adjacency2 = [[1, 2], [0, 3], [0, 3, 4], [1, 2], [2], [6], [5, 7], [6, 8], [7]]
    const answer2 = false
    expect(areTheyConnected(dinos2, adjacency2)).toEqual(answer2);
  });
})