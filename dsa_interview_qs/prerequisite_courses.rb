# You're developing a system for scheduling advising meetings with students in a Computer Science program. Each meeting should be scheduled when
# a student has completed 50% of their academic program. Each course at our university has exactly one prerequisite that must be taken first.
# No two courses share a prerequisite. There is only one path through the program. Write a function that takes a list of (prerequisite, course) pairs,
# and returns the name of the course that the student will be taking when they are halfway through their sequence of courses.
# 
#
#
class Node
  attr_accessor :value, :nxt
  
  def initialize(value, nxt = nil)
    @value = value
    @nxt = nxt
  end
end


answer = "Data Structures"

def course_prerequisites(input)
  course_prereqs = {}
  input.each { |pair| course_prereqs[pair[1]] = pair[0]}
  course_prereqs
end

# puts course_prerequisites(input_1)

def course_linked_list(input_1)
  # hashmap of prereqs as keys and courses as vals
  prereq_course = {}
  input_1.each { |prereq, course| prereq_course[prereq] = course }
  
  courses = input_1.flatten.uniq
  # the courses which are not listed with a prerequisite
  first_course = (courses - prereq_course.values)[0]
  
  # define head with the first course (the one with no prerequisite listed)
  ll_head = Node.new(first_course)
  current_node = ll_head
  
  # look up the current course in the prereq hashmap,
  # set the next node to the course that follows on from the prerequisite course,
  # reset current to next, while loop ends on the final course because
  # it's not a prerequisite to any further course
  while prereq_course[current_node.value]
    current_node.nxt = Node.new(prereq_course[current_node.value])
    current_node = current_node.nxt
  end
  
  ll_head
end

def mid_course(input)
  ll_head = course_linked_list(input)
  slow, fast = ll_head, ll_head
  
  while fast&.nxt&.nxt
    slow = slow.nxt
    fast = fast.nxt.nxt
  end
  
  slow.value
end

# Example 1:
input_1 = [
  ["Foundations of Computer Science", "Operating Systems"],
  ["Data Structures", "Algorithms"],
  ["Computer Networks", "Computer Architecture"],
  ["Algorithms", "Foundations of Computer Science"],
  ["Computer Architecture", "Data Structures"],
  ["Software Design", "Computer Networks"]
]
answer_1 = "Data Structures"
output_1 = mid_course(input_1)
puts output_1 == answer_1 ? "✅passes - with the correct mid course of; #{output_1}"
: "❌fails - mid course shoudl be #{answer_1}, but code returned #{output_1}"

# Example 2:
input_2 = [
  ["Math", "Physics"]
]
answer_2 = "Math"
output_2 = mid_course(input_2)
puts output_2 == answer_2 ? "✅passes - with the correct mid course of; #{output_2}"
: "❌fails - mid course shoudl be #{answer_2}, but code returned #{output_2}"

# Example 3:
input_3 = [
  ["Intro", "Intermediate"],
  ["Intermediate", "Advanced"]
]

answer_3 = "Intermediate"
output_3 = mid_course(input_3)
puts output_3 == answer_3 ? "✅passes - with the correct mid course of; #{output_3}"
: "❌fails - mid course shoudl be #{answer_3}, but code returned #{output_3}"

# Example 4:
input_4 = [
  ["E", "F"],
  ["A", "B"],
  ["D", "E"],
  ["C", "D"],
  ["B", "C"]
]
answer_4 = "C"
output_4 = mid_course(input_4)
puts output_4 == answer_4 ? "✅passes - with the correct mid course of; #{output_4}"
: "❌fails - mid course shoudl be #{answer_4}, but code returned #{output_4}"