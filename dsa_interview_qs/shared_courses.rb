# You are a developer for a university. Your current project is to develop a system for students to find courses they share with friends. The university has a system for querying courses students are enrolled in, returned as a list of (ID, course) pairs.

# Write a function that takes in a collection of (student ID number, course name) pairs and returns, for every pair of students, a collection of all courses they share.

# Sample Input:
# 
def find_pairs(arr)
results = {}
  
  arr.each_with_index do |entry1, idx1|
    id1, course1 = entry1[0], entry1[1]  
  
  
    arr[idx1 + 1..-1].each_with_index do |entry2, idx2|
      id2, course2 = entry2[0], entry2[1]
      sorted_key = [id1, id2].sort.join(',')
      # key1 = "#{id1},#{id2}"
      # key2 = "#{id2},#{id1}"
      
      # if course1 == course2
      if id1 != id2
        if course1 == course2
          puts "COURSES MATCH FOR id1-#{id1} & id2-#{id2} - course1#{course1} course2#{course2} sortedkey - #{sorted_key}"
          # puts "key1 = #{key1}"
          # puts "key2 = #{key2}"
          # puts "results = #{results}"

          if results[sorted_key]
            results[sorted_key] << course1
          else
            # update existing entry
            results[sorted_key] = [course1]
          end

        else
          results[sorted_key] = [] if !results[sorted_key]
        end
      end
    end
  end

  results
end

enrollments1 = [
  ["58", "Linear Algebra"],
  ["94", "Art History"],
  ["94", "Operating Systems"],
  ["17", "Software Design"],
  ["58", "Mechanics"],
  ["58", "Economics"],
  ["17", "Linear Algebra"],
  ["17", "Political Science"],
  ["94", "Economics"],
  ["25", "Economics"],
  ["58", "Software Design"],
]

# Sample Output (pseudocode, in any order):
# find_pairs(enrollments1) =>
output_1 = {
  "58,17": ["Software Design", "Linear Algebra"],
  "58,94": ["Economics"],
  "58,25": ["Economics"],
  "94,25": ["Economics"],
  "17,94": [],
  "17,25": []
}

# Example 1:
enrollments2 = [
  ["0", "Advanced Mechanics"],
  ["0", "Art History"],
  ["1", "Course 1"],
  ["1", "Course 2"],
  ["2", "Computer Architecture"],
  ["3", "Course 1"],
  ["3", "Course 2"],
  ["4", "Algorithms"]
]

# Sample output:
# find_pairs(enrollments2) =>
output_2 = {
  "1,0":[],
  "2,0":[],
  "2,1":[],
  "3,0":[],
  "3,1":["Course 1", "Course 2"],
  "3,2":[],
  "4,0":[],
  "4,1":[],
  "4,2":[],
  "4,3":[]
}

# Example 3:
enrollments3 = [
  ["23", "Software Design"], 
  ["3", "Advanced Mechanics"], 
  ["2", "Art History"], 
  ["33", "Another"],
]

# Sample output:
# find_pairs(enrollments3) =>
output_3 = {
  "23,3": [],
  "23,2": [],
  "23,33":[],
  "3,2":  [],
  "3,33": [],
  "2,33": []
}
# All Test Cases:
puts find_pairs(enrollments1).inspect
# find_pairs(enrollments2)
# find_pairs(enrollments3)
# Complexity analysis variables:

# n: number of student,course pairs in the input
# s: number of students
# c: total number of courses being offered (note: The number of courses any student can take is bounded by a small constant)