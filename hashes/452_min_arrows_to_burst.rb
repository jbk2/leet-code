# There are some spherical balloons taped onto a flat wall that represents the XY-plane.
# The balloons are represented as a 2D integer array points where points[i] = [xstart, xend] denotes a balloon
# whose horizontal diameter stretches between xstart and xend. You do not know the exact y-coordinates of the balloons.
# Arrows can be shot up directly vertically (in the positive y-direction) from different points along the x-axis.
# A balloon with xstart and xend is burst by an arrow shot at x if xstart <= x <= xend.
# There is no limit to the number of arrows that can be shot. A shot arrow keeps traveling up infinitely, bursting any balloons in its path.
#      -   ---   - 
#    ----       ----
#       --     -- 

# Constraints:
# 1 <= points.length <= 105
# points[i].length == 2
# -231 <= xstart < xend <= 231 - 1

# Given the array points, return the minimum number of arrows that must be shot to burst all balloons.

def min_arrows_to_burst(points)
  points.sort_by! { |start_x, end_x| end_x }
  arrow_count = 0
  last_x = nil

  points.each do |s, e|
    if last_x.nil? || s > last_x
      arrow_count += 1
      last_x = e
    end
  end

  arrow_count
end

# Naive approach
# want to hit locations where as many baloons on that x coord
# once a baloon is hit, delete from x-coords
# algo:
# count no of baloons as any one x position
# sheet arrow to positions with max counts then remove burst baloons
# re-shoot at max positions - remove baloons, re-shoot until none left

RSpec.describe ":min_arrows_to_burst" do
  it "test 1" do
    input = [[10,16],[2,8],[1,6],[7,12]]
    answer = 2
    output = min_arrows_to_burst(input)
    expect(output).to eq(answer)
  end
  
  it "test 2" do
    input = [[1,2],[3,4],[5,6],[7,8]]
    answer = 4
    output = min_arrows_to_burst(input)
    expect(output).to eq(answer)
  end
  
  it "test 3" do
    input = [[1,2],[2,3],[3,4],[4,5]]
    answer = 2
    output = min_arrows_to_burst(input)
    expect(output).to eq(answer)
  end
end
