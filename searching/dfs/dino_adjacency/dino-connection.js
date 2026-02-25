// Challenge:
// **********
// In a graph representing a portion of the Dinosaur social network, find out if two given dinosaurs are "connected".
// To be "connected", there needs to be a path from one dinosaur to the other.
// The path could be longer than 1, i.e. the connection does not need to be direct.

// Task:
// *****
// Implement the function `areTheyConnected()`.
// 1. Write the algorithm.
// 2. Implement it.
// 3. Run the tests using `npm test` to make sure it works as expected.
// 4. Analyze the time complexity in terms of vertexes, V, and edges, E.

// Constraints:
// ************

// 1. The graph will contain at least 2 vertexes.
// 2. The graph may contain cycles.

// const dinos1 = [0, 4]
// const adjacency1 = [[1, 2], [0, 3], [0, 3, 4], [1, 2], [2], [6], [5, 7], [6, 8], [7]]

import { Queue } from './queue'
import { Stack } from './stack'

export function areTheyConnected(dinos, adjList) {
  const startDino = dinos[0];
  const endDino = dinos[1];
  if (startDino == endDino) return true;
  
  const queue = new Queue();
  const visited = new Set([startDino])
  // fn to recurse through list add all to queue
  const populateQueue = ((neighbours) => {
    for (const neighbour of neighbours) {
      if (neighbour === endDino) return true;
      if (visited.has(neighbour)) continue;
      
      visited.add(neighbour);
      queue.enqueue(neighbour);
      
      if (populateQueue(adjList[neighbour])) return true;
    }
    return false;
  });
  
  // call recurse list fn with first dino's connections
  if (populateQueue(adjList[startDino])) return true;

  // iterate through queue, check if any equal end dino index
  while (!queue.isEmpty) {
    let current = queue.dequeue();
    if (current == endDino) return true;
  };

  return false;
}


