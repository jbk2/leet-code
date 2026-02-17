// Steps:
// 1. If there is one or no number in the array:
// 2.   Return the array. It's already sorted.
// 3. Find the index of the mid point in the array.
// 4. Get a copy of the left half of the array.
// 5. Get a copy of the right half of the array.
// 6. Sort the left half.
// 7. Sort the right half.
// 8. Merge the two sorted halves and return the result.
// */

export default function mergeSort(arr) {
  const sort = (vals) => {
    if (vals.length <= 1) return vals;
    
    const midIdx = Math.floor(vals.length / 2);
    const left = sort(vals.slice(0, midIdx));
    const right = sort(vals.slice(midIdx));

    return merge(left, right);
  }

  const merge = (l, r) => {
    const merged = []
    let i = 0, j = 0

    while (i < l.length & j < r.length) {
      if (l[i] < r[j]) merged.push(l[i++]);
      else merged.push(r[j++]);
    }
    return merged.concat(l.slice(i), r.slice(j));
  }

  return sort(arr);
}



