require_relative './binary_tree_helper'
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end
# @param {TreeNode} root
# @return {Integer}

def max_depth(root)
  max_depth = 0
  return max_depth if root.nil?

  depth = lambda do |node, depth_count|
    max_depth = [max_depth, depth_count].max
    depth.call(node.left, depth_count + 1) if node.left
    depth.call(node.right, depth_count + 1) if node.right
  end
  
  depth.call(root, 1)

  max_depth
end

root = TreeNode.new(4)
two = TreeNode.new(2)
seven = TreeNode.new(7)
one = TreeNode.new(1)
three = TreeNode.new(3)
assign_leaves(two, one, three)
assign_leaves(root, two, seven)

puts max_depth(root)