# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val)
#         @val = val
#         @next = nil
#     end
# end

# @param {ListNode} headA
# @param {ListNode} headB
# @return {ListNode}
def getIntersectionNode(headA, headB)
  node_a, node_b = headA, headB
  
  while node_a != node_b
      node_a = node_a ? node_a.next : headB
      node_b = node_b ? node_b.next : headA
  end
  
  node_a
end