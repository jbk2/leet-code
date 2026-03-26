# You are given an integer array matches where matches[i] = [winneri, loseri] indicates that the player winneri defeated player loseri in a match.

# Return a list answer of size 2 where:
  # answer[0] is a list of all players that have not lost any matches.
  # answer[1] is a list of all players that have lost exactly one match.
  # The values in the two lists should be returned in increasing order.

# Note:
  # You should only consider the players that have played at least one match.
  # The testcases will be generated such that no two matches will have the same outcome.
 
def lost_zero_or_one(matches)
  result_counts = Hash.new { |h, k| h[k] = { wins: 0, losses: 0 } }
  
  matches.each do |winner, loser|
    result_counts[winner][:wins] += 1
    result_counts[loser][:losses] += 1
  end
  
  winners = result_counts.select { |_, v| v[:losses] == 0 }.keys.sort
  losers = result_counts.select { |_, v| v[:losses] == 1 }.keys.sort
  [winners, losers]
end

# Example 1:
matches_1 = [[1,3],[2,3],[3,6],[5,6],[5,7],[4,5],[4,8],[4,9],[10,4],[10,9]]
answer_1 = [[1,2,10],[4,5,7,8]]
output_1 = lost_zero_or_one(matches_1)
puts output_1 == answer_1 ? "✅ correct; #{output_1[0]} lost zero matches, and #{output_1[1]} lost one match only"
  : "❌ incorrect - answer shoudl be; #{answer_1} not; #{output_1}"
# Explanation:
# Players 1, 2, and 10 have not lost any matches.
# Players 4, 5, 7, and 8 each have lost one match.
# Players 3, 6, and 9 each have lost two matches.
# Thus, answer[0] = [1,2,10] and answer[1] = [4,5,7,8].


# Example 2:
matches_2 = [[2,3],[1,3],[5,4],[6,4]]
answer_2 = [[1,2,5,6],[]]
output_2 = lost_zero_or_one(matches_2)
puts output_2 == answer_2 ? "✅ correct; #{output_2[0]} lost zero matches, and #{output_2[1]} lost one match only"
  : "❌ incorrect - answer shoudl be; #{answer_2} not; #{output_2}"
# Explanation:
# Players 1, 2, 5, and 6 have not lost any matches.
# Players 3 and 4 each have lost two matches.
# Thus, answer[0] = [1,2,5,6] and answer[1] = [].
 

# Constraints:
# 1 <= matches.length <= 105
# matches[i].length == 2
# 1 <= winneri, loseri <= 105
# winneri != loseri
# All matches[i] are unique.