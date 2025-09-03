require_relative './linked_list'

# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end
# @param {ListNode} head
# @return {Boolean}

module Palindrome
  def is_palindrome?(head)
    return true if head.nil? || head.next.nil?

    orig_head = head
    fast = orig_head # detect end
    slow = orig_head # when fast at end this is either at middle (if odd # of nodes) or end of 1st half (if even # of nodes)

    while fast.next&.next
      fast = fast.next.next
      slow = slow.next
    end

    half1 = head
    half2 = slow.next = reverse_list(slow.next)

    while half1 && half2
      if half1.val != half2.val
        slow.next = reverse_list(slow.next)
        return false
        # head.inspect
      end

      half1 = half1.next
      half2 = half2.next
    end

    slow.next = reverse_list(slow.next)
    return true
    # head.inspect
  end

  def reverse_list(head)
    prev = nil
    curr = head

    while curr
      nxt = curr.next
      curr.next = prev
      prev = curr
      curr = nxt
    end

    prev
  end
end

include Palindrome

test_arr1 = [1, 2, 2, 1]
test_arr2 = [1, 2]
test_arr3 = [1, 2, 3, 3, 2, 1]
test_arr4 = [1, 2, 3, 3, 2, 2, 1]
test_ll1 = create_linked_list(test_arr1)
test_ll2 = create_linked_list(test_arr2)
test_ll3 = create_linked_list(test_arr3)
test_ll4 = create_linked_list(test_arr4)
# puts test_ll1.inspect
# puts test_ll2.inspect

is_palindrome?(test_ll1) ? (puts "✅ test_ll1 passes") : (puts "❌ test_ll1 fails")
is_palindrome?(test_ll2) ? (puts "❌ test_ll2 fails") : (puts "✅ test_ll2 passes")
is_palindrome?(test_ll3) ? (puts "✅ test_ll3 passes") : (puts "❌ test_ll3 fails")
is_palindrome?(test_ll4) ? (puts "❌ test_ll4 fails") : (puts "✅ test_ll4 passes")