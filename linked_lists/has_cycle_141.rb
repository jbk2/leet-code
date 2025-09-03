# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val)
#         @val = val
#         @next = nil
#     end
# end

# @param {ListNode} head
# @return {Boolean}
def hasCycle(head)
  slow_pointer = head
  fast_pointer = head
  
  while fast_pointer && fast_pointer.next
      slow_pointer = slow_pointer.next
      fast_pointer = fast_pointer.next.next
      return true if fast_pointer.equal?(slow_pointer)
  end
  
  false
end