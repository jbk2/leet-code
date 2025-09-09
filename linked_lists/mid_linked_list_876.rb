def middle_node(head)
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