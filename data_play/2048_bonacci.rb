# 2048-bonacci
# 2048 is a tiny video game that was super hype some years ago. You had to fuse two equal numbers to create its double. So 1 and 1 became 2, 2 and 2 became 4, and so on.

# Fibonacci was a famous mathematician who made the super-hype Fibonacci sequence you may have heard about: U(n+1) = U(n) + U(n-1). The first number of the sequence are 1, 1, 2, 3, 5, 8, 13, ...

# Let's combine these two hype things to create a super-super-hype game!

# 2048-bonacci plays on a 4x4 square. Each square is either empty or contains a number of the Fibonacci sequence.

# You are given an initial board situation (a 2D array of integers) and a pushing direction (up, left, down, or right). Then, you must compute the board contents after the push and return an updated 2D array of integers.

# The value of integers in the array is guaranteed to be less than 2^16 and are all Fibonacci numbers. The value 0 means the square is empty.

# Rule 1
# Numbers move as far as possible in the pushing direction.

# -------------                       -------------
# | 2|  |  |  |                       |  |  |  |  |
# -------------                       -------------
# |  |  |13|  |                       |  |  |  |  |
# -------------  => push downward =>  -------------
# |  |  |  |  |                       | 2|  |  |  |
# -------------                       -------------
# | 5|  |  |  |                       | 5|  |13|  |
# -------------                       -------------


# Rule 2
# When two consecutive numbers in the Fibonacci sequence are pushed one on another, they fuse into the next number.


# Rule 3
# Fusing orders are resolved in the backward direction of the push.

# A fused number can not be fused once again in the same turn.


# Rule 4
# Numbers can move to a square that a fusing has just emptied.


# Let's hype!


class Direction
  UP = :up
  DOWN = :down
  LEFT = :left
  RIGHT = :right
end

Di = Direction

class The2048Bonacci
  attr_accessor :game_area, :width, :height
  attr_reader :fibs_10

  def initialize(game_area)
    @game_area = game_area
    @width = game_area[0].length
    @height = game_area.length
    @fibs_10 = fibs_nos_to(10)
    populate_game
  end

  def get_tile(x, y)
    @game_area[y][x]
  end

  def set_tile(x, y, fib_value)
    @game_area[y][x] = fib_value
  end

  def populate_game
    4.times do |_|
      x, y = rand(0..3), rand(0..3)
      value = fibs_10[rand(0..9)]
      game_area[y][x] = value
    end
  end

  def get_description
    str_lines = []
    @game_area.each do |line|
      str_line = line.map { |fib_val| "%2d" % fib_val }.join(" ")
      str_lines << str_line
    end
    str_lines.join("\n")
  end

  def fibs_nos_to(n)
    fibs = [0, 1]
    n.times { |i| fibs << fibs[-1] + fibs[-2]}
    fibs
  end
end

area = Array.new(4) { Array.new(4, 0) }

game = The2048Bonacci.new(area)
puts game.get_description
