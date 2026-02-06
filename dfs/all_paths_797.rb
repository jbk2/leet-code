# Given a directed acyclic graph (DAG) of n nodes labeled from 0 to n - 1, find all possible paths from node 0 to node n - 1 and return them in any order.
# The graph is given as follows: graph[i] is a list of all nodes you can visit from node i (i.e., there is a directed edge from node i to node graph[i][j]).
# 
#

def paths(input)
  paths = []
  # definition of 
  paths
end


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
puts output_2 == answer_ ? "✅passes - with the correct paths of; #{output_2}"
: "❌fails - paths should be #{answer_2}, but were #{output_2}"