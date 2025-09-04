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

def flatten(root)
  return if root.nil?

  head = root
  curr = root
  stack = []

  while curr
    if curr.child
      stack << curr.next if curr.next
      curr.next = curr.child
      curr.next.prev = curr
      curr.child = nil
    elsif curr.next.nil? && !stack.empty?
      nxt = stack.pop
      curr.next = nxt
      curr.next.prev = curr
    end
    curr = curr.next
  end

  head
end
