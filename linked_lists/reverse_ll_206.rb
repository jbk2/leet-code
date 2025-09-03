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
def reverse_list(head)
  new_head = nil
  orig_head = head
  
  while orig_head
      new_head = ListNode.new(orig_head.val, new_head)
      orig_head = orig_head.next
  end
  
  new_head
  
end