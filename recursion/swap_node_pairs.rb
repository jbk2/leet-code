# Input: head = [1,2,3,4]
# Output: [2,1,4,3]

def swap_pairs(head)
  return head if head.nil? || head.next.nil?

  first = head
  second = head.next

  first.next = swap_pairs(second.next)
  second.next = first
  second
end