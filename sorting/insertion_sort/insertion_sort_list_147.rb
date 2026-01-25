# Given the head of a singly linked list, sort the list using insertion sort,
# and return the sorted list's head.

# The steps of the insertion sort algorithm:
# Insertion sort iterates, consuming one input element each repetition and growing a sorted output list.
# At each iteration, insertion sort removes one element from the input data, finds the location it belongs within the sorted list and inserts it there.
# It repeats until no input elements remain.
# 
# Constraints:
# The number of nodes in the list is in the range [1, 5000].
# -5000 <= Node.val <= 5000 
# 
# Definition for singly-linked list.
class ListNode
  attr_accessor :val, :next

  def initialize(val = 0, _next = nil)
      @val = val
      @next = _next
  end
end

def build_linked_list(arr)
  nodes = []
  
  arr.each_index do |idx|
    nodes[idx] = ListNode.new(arr[idx])
  end

  nodes.each_with_index do |node, idx|
    unless idx >= nodes.length - 1
      node.next = nodes[idx + 1]
    end
  end

  nodes[0]
end

def insertion_sort_list(head)
  dummy_head = ListNode.new(-Float::INFINITY)
  current = head
  
  while current
    next_current = current.next
    dummy_prev = dummy_head

    while dummy_prev.next && dummy_prev.next.val <= current.val
      dummy_prev = dummy_prev.next
    end

    tail = dummy_prev.next
    dummy_prev.next = current
    dummy_prev.next.next = tail
    current = next_current
  end
  dummy_head.next
end

def sll_to_arr(ll)
  arr = []
  while ll
    arr << ll.val
    ll = ll.next
  end
  arr
end


# Example 1:
head_1 = build_linked_list([4,2,1,3])
result_1 =  sll_to_arr(build_linked_list([1,2,3,4]))
output_1 = sll_to_arr(insertion_sort_list(head_1))
puts output_1 == result_1 ? "✅passes - with the correctly sorted output; #{output_1}"
  : "❌fails - output is #{output_1.inspect}, but should be #{result_1.inspect}"


# Example 2:
head_2 = build_linked_list([-1,5,3,4,0])
result_2 = sll_to_arr(build_linked_list([-1,0,3,4,5]))
output_2 = sll_to_arr(insertion_sort_list(head_2))
puts output_2 == result_2 ? "✅passes - with the correctly sorted output; #{output_2}"
  : "❌fails - output is #{output_2}, but should be #{result_2}"
