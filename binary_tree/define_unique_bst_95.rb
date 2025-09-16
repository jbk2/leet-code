class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end
# @param {Integer} n
# @return {TreeNode[]}

def generate_trees(n)
  return [] if n == 0

  generate = lambda do |l, r|
    return [nil] if l > r
    result = []

    (l..r).each do |root|
      left_nodes = generate.call(l, root - 1)
      right_nodes = generate.call(root + 1, r)

      left_nodes.each do |left|
        right_nodes.each do |right|
          node = TreeNode.new(root)
          node.left = left
          node.right = right
          result << node
        end
      end
    end
    result
  end

  generate.call(1, n)
end

puts generate_trees(3).count
puts generate_trees(3).inspect
