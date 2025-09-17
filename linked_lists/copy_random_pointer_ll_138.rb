# require_relative 'linked_list_helper'

# Definition for Node.
class Node
  attr_accessor :val, :next, :random
  def initialize(val = 0)
    @val = val
    @next = nil
    @random = nil
  end
end

# @param {Node} node
# @return {Node}

# def copy_random_list(head)
#   return nil if head.nil?
#   curr = head

#   new_arr = []
#   orig_node_indexes = {}

#   index = 0
#   tail = nil

#   while curr
#     new_node = Node.new(curr.val)
#     new_arr << new_node
#     orig_node_indexes[curr] = index

#     tail.next = new_node if tail
#     tail = new_node
#     curr = curr.next
#     index += 1
#   end

#   curr = head
#   index = 0

#   while curr
#     orig_random = curr.random
#     new_arr[index].random = orig_random ? new_arr[orig_node_indexes[orig_random]] : nil
#     curr = curr.next
#     index += 1
#   end

#   new_arr.first
# end

# def copy_random_list(head)
#   map = {}
#   curr = head

#   while curr
#     map[curr] = Node.new(curr.val)
#     curr = curr.next
#   end

#   curr = head

#   while curr
#     map[curr].next = map[curr.next]
#     map[curr].random = map[curr.random]
#     curr = curr.next
#   end

#   map[head]
# end

def copy_random_list(head)
  clone_node = lambda do |node, memo|
    return nil if node.nil?
    return memo[node] if memo[node]

    new_head = Node.new(node.val)
    memo[node] = new_head

    memo[node.next] = clone_node.call(node.next, memo)
    memo[node.random] = clone_node.call(node.random, memo)

    new_head
  end

  clone_node.call(head, {})
end



# Input: head = [[7,null],[13,0],[11,4],[10,2],[1,0]]
  first_node = Node.new(7)
  second_node = Node.new(13)
  third_node = Node.new(11)
  fourth_node = Node.new(10)
  fifth_node = Node.new(1)

  first_node.next = second_node
  second_node.next = third_node
  third_node.next = fourth_node
  fourth_node.next = fifth_node
  
  first_node.random = nil
  second_node.random = first_node
  third_node.random = fifth_node
  fourth_node.random = third_node
  fifth_node.random = first_node

  head = first_node

  puts copy_random_list(head).inspect

# Output: [[7,null],[13,0],[11,4],[10,2],[1,0]]

# Input: head = [[1,1],[2,1]]
# Output: [[1,1],[2,1]]

# Input: head = [[3,null],[3,0],[3,null]]
# Output: [[3,null],[3,0],[3,null]]