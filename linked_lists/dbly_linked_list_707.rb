class Node
  attr_accessor :val, :prev, :next

  def initialize(val, _prev = nil, _next = nil)
    @val = val
    @prev = _prev
    @next = _next
  end
end

class DblyLinkedList
  def initialize
    @head = nil
  end

  # :type index: Integer
  # :rtype: Integer
  def get(index)
    return -1 if index.negative?

    node = @head

    index.times { node = node&.next }

    node ? node.val : -1
  end

  # :type val: Integer
  # :rtype: Void
  def add_at_head(val)
    new_node = Node.new(val)

    if @head.nil?
      @head = new_node
      return
    end

    @head.prev = new_node
    new_node.next = @head
    @head = new_node
  end

  # :type val: Integer
  # :rtype: Void
  def add_at_tail(val)
    new_node = Node.new(val)

    if @head.nil?
      @head = new_node
      return
    end

    tail_node = @head
    tail_node = tail_node.next while tail_node.next
    new_node.prev = tail_node
    tail_node.next = new_node
  end


  # :type index: Integer
  # :type val: Integer
  # :rtype: Void
  def add_at_index(index, val)
    if @head.nil?
      return if index.positive?

      @head = Node.new(val)
    end

    if index <= 0
      new_node = Node.new(val)
      @head.prev = new_node
      new_node.next = @head
      @head = new_node
      return
    end

    prev_node = @head

    (index - 1).times do
      prev_node = prev_node&.next
    end

    return if prev_node.nil?

    new_node = Node.new(val)
    new_node.next = prev_node.next
    new_node.prev = prev_node
    prev_node.next = new_node
  end

  # :type index: Integer
  # :rtype: Void
  def delete_at_index(index)
    return if index.negative? || @head.nil?

    if index.zero?
      @head = @head.next
      @head.prev = nil if @head
      return
    end

    prev_node = @head

    (index - 1).times do
      prev_node = prev_node&.next
    end

    return if prev_node.nil? || prev_node.next.nil?

    prev_node.next = prev_node.next.next
    prev_node.next.prev = prev_node if prev_node.next
  end
end

# Your MyLinkedList object will be instantiated and called as such:
# obj = MyLinkedList.new()
# param_1 = obj.get(index)
# obj.add_at_head(val)
# obj.add_at_tail(val)
# obj.add_at_index(index, val)
# obj.delete_at_index(index)