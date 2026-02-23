# In a town, there are n people labeled from 1 to n. There is a rumor that one of these people is secretly the town judge.
# If the town judge exists, then:
  # The town judge trusts nobody.
  # Everybody (except for the town judge) trusts the town judge.
  # There is exactly one person that satisfies properties 1 and 2.
# You are given an array trust where trust[i] = [ai, bi] representing that the person labeled ai trusts the person labeled bi.
# If a trust relationship does not exist in trust array, then such a trust relationship does not exist.
# Return the label of the town judge if the town judge exists and can be identified, or return -1 otherwise.

# Constraints:
# 1 <= n <= 1000
# 0 <= trust.length <= 104
# trust[i].length == 2
# All the pairs of trust are unique.
# ai != bi
# 1 <= ai, bi <= n

def judge_idx(n, trusts)
  trusters = Hash.new(0)
  trusted = Hash.new(0)
   
  trusts.each do |trust|
    trusters[trust[0]] += 1 # judge should not be a key in here, shoudl also be n-1 long
    trusted[trust[1]] += 1 #judge must have a count of n - 1 in here
  end

  all_people = (1..n).to_a
  non_trusters = all_people.difference(trusters.keys)
  non_truster = all_people.difference(trusters.keys)[0]

  return -1 if non_trusters.length != 1
  
  judge = non_truster if trusted[non_truster] == n - 1
  
  judge || -1
end


# Example 1:
n_1 = 2
trust_1 = [[1,2]]
answer_1 = 2
output_1 = judge_idx(n_1, trust_1)
puts output_1 == answer_1 ? "✅passes - yes judge is at index #{output_1}" : "❌fails - judge is at index #{answer_1} not at index #{output_1}"

# Example 2:
n_2 = 3
trust_2 = [[1,3],[2,3]]
answer_2 =  3
output_2 = judge_idx(n_2, trust_2)
puts output_2 == answer_2 ? "✅passes - yes judge is at index #{output_2}" : "❌fails - judge is at index #{answer_2} not at index #{output_2}"

# Example 3:
n_3 = 3
trust_3 = [[1,3],[2,3],[3,1]]
answer_3 = -1
output_3 = judge_idx(n_3, trust_3)
puts output_3 == answer_3 ? "✅passes - yes judge is at index #{output_3}" : "❌fails - judge is at index #{answer_3} not at index #{output_3}"

# Example 4:
n_4 = 3
trust_4 = [[1,2],[2,3]]
answer_4 =  -1
output_4 = judge_idx(n_4, trust_4)
puts output_4 == answer_4 ? "✅passes - yes judge is at index #{output_4}" : "❌fails - judge is at index #{answer_4} not at index #{output_4}"
