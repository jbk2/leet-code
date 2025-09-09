class ListNode
  attr_accessor :val, :next

  def initialize(val, _next = nil)
    @val = val
    @next = _next
  end
end

def build_linked_list
  first_node = ListNode.new(1)
  second_node = ListNode.new(2)
  third_node = ListNode.new(3)
  fourth_node = ListNode.new(4)
  fifth_node = ListNode.new(5)

  first_node.next = second_node
  second_node.next = third_node
  third_node.next = fourth_node
  fourth_node.next = fifth_node
  first_node
end