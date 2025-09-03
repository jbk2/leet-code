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
    fast = orig_head
    slow = orig_head

    while fast.next&.next
      fast = fast.next.next
      slow = slow.next
    end

    half1 = head
    half2 = reverse_list(slow.next)
    slow.next = half2

    while half1 && half2
      if half1.val != half2.val
        slow.next = reverse_list(half2)
        return false 
      end

      half1 = half1.next
      half2 = half2.next
    end

    slow.next = reverse_list(half2)
    true
  end

  # module_function :is_palindrome?
  # private_class_method :reverse_list

  # private

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
test_ll1 = create_linked_list(test_arr1)
test_ll2 = create_linked_list(test_arr2)

# puts test_ll1.inspect
# puts test_ll2.inspect

puts is_palindrome?(test_ll1)
puts is_palindrome?(test_ll2)