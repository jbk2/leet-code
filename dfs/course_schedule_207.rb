# There are a total of numCourses courses you have to take, labeled from 0 to numCourses - 1. You are given an array prerequisites where
# prerequisites[i] = [ai, bi] indicates that you must take course bi first if you want to take course ai.
# For example, the pair [0, 1], indicates that to take course 0 you have to first take course 1.
# Return true if you can finish all courses. Otherwise, return false.

def can_finish(num_courses, prereqs)
  course_prereqs = {}
  prereqs.each { |course, prereq| course_prereqs[course] = prereq }
  
  course_count = 0
  # for each course can I complete 
  
  course_prereqs
end


# Example 1:
num_courses_1 = 2
prerequisites_1 = [[1,0]]
answer_1 = true
puts can_finish(num_courses_1, prerequisites_1)
# Explanation: There are a total of 2 courses to take. 
# To take course 1 you should have finished course 0. So it is possible.

# Example 2:
num_courses_2 = 2
prerequisites_2 = [[1,0],[0,1]]
answer_2 = false
# Explanation: There are a total of 2 courses to take. 
# To take course 1 you should have finished course 0, and to take course 0 you should also have finished course 1. So it is impossible.