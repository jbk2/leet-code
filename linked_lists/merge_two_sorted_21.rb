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
def merge_two_lists(list1, list2)
  return list1 || list2 unless list1 && list2

  list2_larger = list1.val <= list2.val
  head = tail = list2_larger ? list1 : list2
  list2_larger ? list1 = list1.next : list2 = list2.next

  while list1 && list2
    list2_larger = list1.val <= list2.val

    if list2_larger
      tail.next = list1
      list1 = list1.next
    else
      tail.next = list2
      list2 = list2.next
    end

    tail = tail.next
  end

  tail.next = list1 || list2

  head
end
