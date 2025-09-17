# Definition for a Node.
# class Node
#     attr_accessor :val, :next
#     def initialize(val=nil, next_=nil)
#         @val = val
#         @next = next_
#     end
# end

# @param {Node} head
# @param {Integer} insertVal
# @return {Node}

def insert(head, insert_val)
  if head.nil?
    head = Node.new
    head.val = insert_val
    head.next = head
    return head
  end

  initial_head = head
  curr = head

  fits = lambda do |prev, _next, new_val|
    return true if prev <= new_val && _next >= new_val 
    return true if _next < prev && (prev <= new_val || _next >= new_val) 
  end

  curr = curr.next while !fits.call(curr.val, curr.next.val, insert_val) && curr.next != initial_head

  tail = curr.next
  new_node = Node.new
  new_node.val = insert_val
  new_node.next = tail
  curr.next = new_node
  return initial_head
end