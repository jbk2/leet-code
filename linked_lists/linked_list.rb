# Definition for singly-linked list.

class ListNode
    attr_accessor :val, :next
    def initialize(val = 0, _next = nil)
        @val = val
        @next = _next
    end
end
# @param {ListNode} l1
# @param {ListNode} l2
# @return {ListNode}

arr1 = [2, 4, 3]
arr2 = [5, 6, 4]

def create_linked_list(arr)
  head = nil
  tail = nil
  arr.each do |item|
    node = ListNode.new(item)

    if !head
      head = node
      tail = node
    else
      tail.next = node
      tail = node
    end
  end
  head
end

egll1 = create_linked_list(arr1)
egll2 = create_linked_list(arr2)

def sum_vals(node1, node2)
  node1.val + node2.val
end

def add_two_nums(ll1, ll2)
  carry = 0
  arr = []
  
  while ll1 || ll2  || carry != 0
    sum = sum_vals(ll1, ll2) + carry
    carry = 0
  
    carry = (sum / 10)
    arr << (sum % 10) 

    ll1 = ll1 ? ll1.next : nil
    ll2 = ll2 ? ll2.next : nil
  end
  create_linked_list(arr)
end

puts "here's added nums in array"
ll = add_two_nums(egll1, egll2)

while ll
  puts ll.val
  ll = ll.next
end