# @param {Integer[]} job_difficulty
# @param {Integer} d
# @return {Integer}
def min_difficulty(job_difficulty, d)
  
end


# Example 1:
job_difficulty1 = [6,5,4,3,2,1]
d1 = 2
result1 = 7
# Explanation: First day you can finish the first 5 jobs, total difficulty = 6.
# Second day you can finish the last job, total difficulty = 1.
# The difficulty of the schedule = 6 + 1 = 7 

# Example 2:
job_difficulty2 = [9,9,9]
d2 = 4
result2 = -1
# Explanation: If you finish a job per day you will still have a free day. you cannot find a schedule for the given jobs.

# Example 3:
job_difficulty3 = [1,1,1]
d3 = 3
result3 =  3
# Explanation: The schedule is one job per day. total difficulty will be 3.
# 
#test1 = maximal_square(matrix1)
test1 = min_difficulty(job_difficulty1, d1)
test2 = min_difficulty(job_difficulty2, d2)
test3 = min_difficulty(job_difficulty3, d3)
puts test1 == result1 ? "✅passes, with job_difficulty;#{job_difficulty1} & d;#{d1}, result = #{test1}" : "❌fails with withjob_difficulty;#{job_difficulty2} & d;#{d1}, result = #{test1}"
puts test2 == result2 ? "✅passes, with job_difficulty;#{job_difficulty2} & d;#{d2}, result = #{test2}" : "❌fails with withjob_difficulty;#{job_difficulty1} & d;#{d2}, result = #{test2}"
puts test3 == result3 ? "✅passes, with job_difficulty;#{job_difficulty3} & d;#{d3}, result = #{test3}" : "❌fails with withjob_difficulty;#{job_difficulty3} & d;#{d3}, result = #{test3}"