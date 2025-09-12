require_relative './linked_list_helper'

# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end
# @param {ListNode} list1
# @param {ListNode} list2
# @return {ListNode}
# def merge_two_lists(list1, list2)
#   return list1 || list2 unless list1 && list2

#   list2_larger = list1.val <= list2.val
#   head = tail = list2_larger ? list1 : list2
#   list2_larger ? list1 = list1.next : list2 = list2.next

#   while list1 && list2
#     list2_larger = list1.val <= list2.val

#     if list2_larger
#       tail.next = list1
#       list1 = list1.next
#     else
#       tail.next = list2
#       list2 = list2.next
#     end

#     tail = tail.next
#   end

#   tail.next = list1 || list2

#   head
# end

# def merge_two_lists(list1, list2)

#   if list1.val <= list2.val
#     head = tail = list1
#     list1 = list1.next
#   else
#     head = tail = list2
#     list2 = list2.next
#   end

#   while list1 && list2
#     if list1.val <= list2.val
#       tail.next = list1
#       list1 = list1.next
#     else
#       tail.next = list2
#       list2 = list2.next
#     end

#     tail = tail.next
#   end

#   tail.next = list1 || list2
#   head
# end

def merge_two_lists(l1, l2)
  return l1 if l2.nil?
  return l2 if l1.nil?

  if l1.val <= l2.val
    l1.next = merge_two_lists(l1.next, l2)
    l1
  else
    l2.next = merge_two_lists(l1, l2.next)
    l2
  end
end

ll1 = build_linked_list
ll2 = build_linked_list

puts merge_two_lists(ll1, ll2).inspect