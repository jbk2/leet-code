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

def odd_even_list(head)
  return head if head.nil? || head.next.nil?
  
  sorted = head
  odds = sorted
  evens_head = evens = head.next

  while evens && evens.next
      odds.next = odds.next.next
      evens.next = evens.next.next
      odds = odds.next
      evens = evens.next
  end
  
  odds.next = evens_head
  sorted
end