# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end
# @param {ListNode} head
# @param {Integer} val
# @return {ListNode}

def remove_elements(head, val)
  new_list = ListNode.new(0, head)
  prev_node = new_list
  pointer = head
  
  while pointer
      if pointer.val == val
          prev_node.next = prev_node.next&.next
          pointer = pointer.next
      else
          prev_node = prev_node.next
          pointer = pointer.next    
      end
  end
  new_list.next
  
end