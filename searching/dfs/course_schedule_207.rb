# There are a total of numCourses courses you have to take, labeled from 0 to numCourses - 1. You are given an array prerequisites where
# prerequisites[i] = [ai, bi] indicates that you must take course bi first if you want to take course ai.
# For example, the pair [0, 1], indicates that to take course 0 you have to first take course 1.
# Return true if you can finish all courses. Otherwise, return false.

def can_finish(num_courses, prereqs)
  course_prereqs = Array.new(num_courses) { [] }
  
  prereqs.each do |course, prereq|
    course_prereqs[course] << prereq
  end
  
  state = Array.new(num_courses, 0)

  dfs = lambda do |course|
    return false if state[course] == 1
    return true if state[course] == 2

    state[course] = 1
    
    course_prereqs[course].each do |prereq|
      return false unless dfs.call(prereq)
    end
    
    state[course] = 2
    true
  end

  (0...num_courses).all? { |course| dfs.call(course) }
end


# Example 1:
num_courses_1 = 2
prerequisites_1 = [[1,0]]
answer_1 = true
output_1 = can_finish(num_courses_1, prerequisites_1)
puts output_1 == answer_1 ? "✅passes - indeed courses #{output_1 ? 'can' : 'cannot'} be taken"
: "❌fails - courses should #{answer_1 ? 'be' : 'not be'} able to be taken, but your code said they #{output_1 ? 'could' : 'could not'} be taken"
# puts can_finish(num_courses_1, prerequisites_1)
# Explanation: There are a total of 2 courses to take. 
# To take course 1 you should have finished course 0. So it is possible.

# Example 2:
num_courses_2 = 2
prerequisites_2 = [[1,0],[0,1]]
answer_2 = false
output_2 = can_finish(num_courses_2, prerequisites_2)
puts output_2 == answer_2 ? "✅passes - indeed courses #{output_2 ? 'can' : 'cannot'} be taken"
: "❌fails - courses should #{answer_2 ? 'be' : 'not be'} able to be taken, but your code said they #{output_1 ? 'could' : 'could not'} be taken"

# Example 3:
num_courses_3 = 6
prerequisites_3 = [[1,0],[1,2],[3,1],[2,3],[2,4],[4,5],[2,5]]
answer_3 = false
output_3 = can_finish(num_courses_3, prerequisites_3)
puts output_3 == answer_3 ? "✅passes - indeed courses #{output_3 ? 'can' : 'cannot'} be taken"
: "❌fails - courses should #{answer_3 ? 'be' : 'not be'} able to be taken, but your code said they #{output_3 ? 'could' : 'could not'} be taken"