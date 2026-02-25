require 'pry'

# Definition for a binary tree node.
class TreeNode
    attr_accessor :val, :left, :right
    def initialize(val = 0, left = nil, right = nil)
        @val = val
        @left = left
        @right = right
    end
end

def assign_leaves(root_node, l1, l2)
  root_node.left = l1.val < l2.val ? l1 : l2
  root_node.right = l1.val > l2.val ? l1 : l2
end