# Definition for a Node.
# class Node
#     attr_accessor :val, :prev, :next, :child
#     def initialize(val=nil, prev=nil, next_=nil, child=nil)
#         @val = val
#         @prev = prev
#         @next = next_
#         @child = child
#     end
# end

# @param {Node} root
# @return {Node}
# 
#

# if a child store the next somewhere aside and store current as previous
# go down children all the way to bottom
# then go all way to end of nexts on last child
# when at end of nexts go to prev child

def flatten(head)
  return if head.nil?
  dfs(head)
  head
end

def dfs(node)
  curr = node
  last = node

  while curr
    orig_next = curr.next

    if curr.child
      child_head = curr.child
      child_tail = dfs(child_head)

      curr.next = child_head
      child_head.prev = curr
      curr.child = nil

      if orig_next 
        child_tail.next = orig_next
        orig_next.prev = child_tail
      end

      last = child_tail
      curr = child_tail
    else
      last = curr
    end
    curr = curr.next
  end
  last
end