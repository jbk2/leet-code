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
  trust_map = Hash.new(0)
   
  trusts.each do |trust|
    trust_map[trust[0]] = trust[1]
  end

  people = (1..n).to_a
  trusting = trust_map.keys
  judge = people.difference(trusting)[0]
  
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

