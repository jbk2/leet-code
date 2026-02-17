import mergeSort from './merge-sort';
import { describe, test, expect } from 'vitest';

describe('mergeSort function', () => {
  test('given an unsorted array of 6 it returns the sorted array', () => {
    const test_arr = [1, 7, 2, 5, 10, 9];
    const result = [1, 2, 5, 7, 9, 10];
    expect(mergeSort(test_arr)).toEqual(result);
  })
})