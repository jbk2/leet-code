# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val)
#         @val = val
#         @next = nil
#     end
# end

# @param {ListNode} head
# @return {ListNode}
def detectCycle(head)
  nodes = {}
  node = head
  
  while node
      return node if nodes[node]
      nodes[node] = true
      node = node.next
  end
  
  return nil
end