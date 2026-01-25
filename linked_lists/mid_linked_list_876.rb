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

def sll_to_arr(ll)
  arr = []
  while ll
    arr << ll.val
    ll = ll.next
  end
  arr
end

def middle_node1(head)
  return head unless head.next

  length = 1
  tail = head

  while tail.next
    tail = tail.next
    length += 1
  end

  mid_index = (length / 2)
  mid_node = head
  
  mid_index.times do
      mid_node = mid_node.next
  end

  mid_node
end

def middle_node2(head)
  slow = fast = head

  while fast && fast.next
    slow = slow.next
    fast = fast.next.next
  end

  slow  
end

# Example 1:
head_1 = build_linked_list([1,2,3,4,5])
result_1 =  sll_to_arr(build_linked_list([3,4,5]))
output_1 = sll_to_arr(middle_node2(head_1))
# Explanation:  The middle node of the list is node 3.
puts output_1 == result_1 ? "✅passes - with the correct mid node; #{output_1}"
  : "❌fails - output was #{output_1.inspect}, but mid node should be #{result_1.inspect}"

  # Example 2:
head_2 = build_linked_list([1,2,3,4,5,6])
result_2 = sll_to_arr(build_linked_list([4,5,6]))
output_2 = sll_to_arr(middle_node2(head_2))
# Explanation: Since the list has two middle nodes with values 3 and 4, we return the second one.
puts output_2 == result_2 ? "✅passes - with the correct mid node; #{output_2}"
  : "❌fails - output was #{output_2.inspect}, but mid node should be #{result_2.inspect}"