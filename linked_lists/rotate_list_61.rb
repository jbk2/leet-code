require_relative 'linked_list_helper'
# Definition for singly-linked list.
class ListNode
    attr_accessor :val, :next
    def initialize(val = 0, _next = nil)
        @val = val
        @next = _next
    end
end
# @param {ListNode} head
# @param {Integer} k
# @return {ListNode}
def rotate_one_right(head, k)
  return head if head.nil? || head.next.nil? || k == 0

  shift = lambda do |head|
    return if head.nil?

    a = head
    b = head.next

    a.next = b.next
    b.next = a

    b
  end

  dummy = ListNode.new(0)
  dummy.next = head

  prev = dummy
  curr = head
  
  # k.times do
    while curr.next
      prev.next = shift.call(curr)
      prev = prev.next
      curr = prev.next
    end

  # end

  dummy.next
end

def rotate_right(head, k)
  return head if head.nil? || head.next.nil? || k.zero?

  length = 1
  tail = head

  while tail.next
    tail = tail.next
    length += 1
  end

  tail.next = head

  k %= length
  return head if k == 0

  steps = length - k
  new_tail = head

  (steps - 1).times { new_tail = new_tail.next }

  new_head = new_tail.next
  new_tail.next = nil

  new_head
end

head = build_linked_list
# puts head.inspect

puts rotate_right(head, 2).inspect
