# Given a directed acyclic graph (DAG) of n nodes labeled from 0 to n - 1, find all possible paths from node 0 to node n - 1 and return them in any order.
# The graph is given as follows: graph[i] is a list of all nodes you can visit from node i (i.e., there is a directed edge from node i to node graph[i][j]).

def paths(graph)
  last_index = graph.length - 1
  paths = []

  dfs = lambda do |node_idx, path|
    if node_idx == last_index
      paths << path.dup
      path = []
      return
    end

    graph[node_idx].each do |nbr_idx|
      path << nbr_idx
      dfs.call(nbr_idx, path)
      path.pop
    end
  end

  graph[0].each do |nbr_idx|
    dfs.call(nbr_idx, [0, nbr_idx])
  end

  paths
end

# Constraints
# n == graph.length
# 2 <= n <= 15
# 0 <= graph[i][j] < n
# graph[i][j] != i (i.e., there will be no self-loops).
# All the elements of graph[i] are unique.
# The input graph is guaranteed to be a DAG.


# Example 1:
graph_1 = [[1,2],[3],[3],[]]
answer_1 = [[0,1,3],[0,2,3]]
# Explanation: There are two paths: 0 -> 1 -> 3 and 0 -> 2 -> 3.
output_1 = paths(graph_1)
puts output_1 == answer_1 ? "✅passes - with the correct paths of; #{output_1}"
: "❌fails - paths should be #{answer_1}, but were #{output_1}"

# Example 2:
graph_2 = [[4,3,1],[3,2,4],[3],[4],[]]
answer_2 = [[0,4],[0,3,4],[0,1,3,4],[0,1,2,3,4],[0,1,4]]
output_2 = paths(graph_2)
puts output_2 == answer_2 ? "✅passes - with the correct paths of; #{output_2}"
: "❌fails - paths should be #{answer_2}, but were #{output_2}"