# Description:
# You are given a set of rooms, each with a fixed number of seats, and a set of groups, each with a number of people. Your task is to seat as many groups as possible under the following constraints:

# Rooms: Represented as an array seats, where seats[i] is the number of available seats in room i.

# Groups: Represented as an array requests, where requests[j] is the size of group j.

# Seating Rules:

# A group cannot be split across multiple rooms.

# Multiple groups can share the same room as long as the total number of people does not exceed the room's capacity.

# If a group is larger than any room's capacity, it cannot be seated.

# Goal: Return the maximum number of groups that can be seated.

# Constraints:

# 1 <= seats.length, requests.length <= 10^4

# 1 <= seats[i], requests[j] <= 10^9
# 

seats_1 = [5, 10, 8]
requests_1 = [2, 3, 5, 6, 8]
answer_1 = 4

# Explanation:
# Room 1 (5 seats): can seat group 2 (2) and group 1 (3).
# Room 2 (10 seats): can seat group 4 (6) and group 3 (5) → only one fits because 6+5>10, so seat group 4 (6).
# Room 3 (8 seats): can seat group 5 (8).
# Total groups seated: 4.
# 

seats_2 = [3, 3]
requests_2 = [4, 2, 2]
answer_2 = 2

# Explanation:
# Group 1 (4) is too large for any room → cannot be seated.
# Room 1 (3 seats): seat group 2 (2).
# Room 2 (3 seats): seat group 3 (2).
# Total groups seated: 2.
# 

seats_3 = [5, 5, 5]
requests_3 = [10, 3, 2]
answer_3 = 2

# Explanation:
# Group 1 (10) is too large for any room → cannot be seated.
# Remaining groups (3,2) can be seated in rooms 1 and 2 or combined in a room (3+2≤5).
# Total groups seated: 2.
