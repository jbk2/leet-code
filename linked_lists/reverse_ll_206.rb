require_relative'./linked_list_helper'
# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end
# @param {ListNode} head
# @return {ListNode}
#
# def reverse_list(head)
#   new_head = nil
#   orig_head = head

#   while orig_head
#     new_head = ListNode.new(orig_head.val, new_head)
#     orig_head = orig_head.next
#   end

#   new_head

# end

def reverse_list(node)
  return node if node.nil? || node.next.nil?

  head = reverse_list(node.next)

  node.next.next = node
  node.next = nil

  head
end

head = build_linked_list
puts reverse_list(head).inspect
