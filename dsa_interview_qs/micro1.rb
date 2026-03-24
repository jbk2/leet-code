# Description:
# You are given a set of rooms, each with a fixed number of seats, and a set of groups, each with a number of people. Your task is to seat as many groups as possible under the following constraints:

# Rooms: Represented as an array seats, where seats[i] is the number of available seats in room i.
# Groups: Represented as an array of groups, where groups[j] is the size of group j.

# Seating Rules:
# A group cannot be split across multiple rooms.
# Multiple groups can share the same room as long as the total number of people does not exceed the room's capacity.
# If a group is larger than any room's capacity, it cannot be seated.

# Goal: Return the maximum number of groups that can be seated.
# Constraints:
# 1 <= seats.length, requests.length <= 10^4
# 1 <= seats[i], requests[j] <= 10^9


def max_seated_groups(rooms, groups)
  rooms_asc = rooms.sort
  groups_asc = groups.sort
  sat_groups = 0

  groups_asc.each_with_index do |group, group_i|
    rooms_asc.each_with_index do |room, room_i|
      if group <= room
        sat_groups += 1
        rooms_asc[room_i] -= group
        break
      end
    end
  end

  sat_groups
end

rooms_1 = [5, 10, 8]
groups_1 = [2, 3, 5, 6, 8]
answer_1 = 4
output_1 = max_seated_groups(rooms_1, groups_1)
puts output_1 == answer_1 ? "✅ correct - #{output_1} is the max number of groups seatable"
  : "❌ incorrect - #{output_1} is not the most seatable groups, #{answer_1} is"
# Explanation:
# Room 1 (5 seats): can seat group 2 (2) and group 1 (3).
# Room 2 (10 seats): can seat group 4 (6) and group 3 (5) → only one fits because 6+5>10, so seat group 4 (6).
# Room 3 (8 seats): can seat group 5 (8).
# Total groups seated: 4.
# 

rooms_2 = [3, 3]
groups_2 = [4, 2, 2]
answer_2 = 2
output_2 = max_seated_groups(rooms_2, groups_2)
puts output_2 == answer_2 ? "✅ correct - #{output_2} is the max number of groups seatable"
  : "❌ incorrect - #{output_2} is not the most seatable groups, #{answer_2} is"
# Explanation:
# Group 1 (4) is too large for any room → cannot be seated.
# Room 1 (3 seats): seat group 2 (2).
# Room 2 (3 seats): seat group 3 (2).
# Total groups seated: 2.
# 

rooms_3 = [5, 5, 5]
groups_3 = [10, 3, 2]
answer_3 = 2
output_3 = max_seated_groups(rooms_3, groups_3)
puts output_3 == answer_3 ? "✅ correct - #{output_3} is the max number of groups seatable"
  : "❌ incorrect - #{output_3} is not the most seatable groups, #{answer_3} is"
# Explanation:
# Group 1 (10) is too large for any room → cannot be seated.
# Remaining groups (3,2) can be seated in rooms 1 and 2 or combined in a room (3+2≤5).
# Total groups seated: 2.
