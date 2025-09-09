require 'pry'
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
# @param {Integer} val
# @return {TreeNode}

# test tree = [4,2,7,1,3]
root = TreeNode.new(4)
two = TreeNode.new(2)
seven = TreeNode.new(7)
one = TreeNode.new(1)
three = TreeNode.new(3)
assign_leaves(two, one, three)
assign_leaves(root, two, seven)

def search_bst(root, val)
  return nil if root.nil?
  return root if root.val == val

  branch = val > root.val ? root.right : root.left
  search_bst(branch, val)
end


# puts root.inspect
# puts search_bst(root, 2).inspect # should return [2,1,3]
puts search_bst(root, 5).inspect # should return nil
# binding.pry
