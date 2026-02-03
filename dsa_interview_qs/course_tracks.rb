# Students may decide to take different 'tracks' or sequences of courses in the Computer Science curriculum. There may be more than one path
# that passes through the same course, but students follow a single linear track. Once a student is on a track, they must stay on it until its completion.
# Write a function that takes a list of (prerequisite, course) pairs, and returns the name of all of the courses that the students could be taking
# when they are halfway through their track of courses.
 
# [prerequisite, course]
all_courses_1 = [
  ["Logic",                   "COBOL"],
  ["Data Structures",         "Algorithms"],
  ["Creative Writing",        "Data Structures"],
  ["Algorithms",              "COBOL"],
  ["Intro to Computer Science","Data Structures"],
  ["Logic",                   "Compilers"],
  ["Data Structures",         "Logic"],
  ["Creative Writing",        "System Administration"],
  ["Databases",              "System Administration"],
  ["Creative Writing",        "Databases"],
  ["Intro to Computer Science","Graphics"]
]

# starting course == a course has no prerequisite == course never appears on right but does appear on left
# end course == course never appears on left but does appear on right == leaf nodes
# build a tree structure which branches when a course is listed multiple times as a prerequisite to another

def mid_courses(input)
  prerequisites = input.map { |prereq, course| prereq }.flatten.uniq
  courses = input.map { |prereq, course| course }.flatten.uniq
  roots = prerequisites - courses
  leaves = courses - prerequisites

  # create a map of => take a root, look up it's following course, take that course look up it's following course, when no longer has following course you're at a leaf
  # hashmap, keys of prereq courses, values an array of courses that follow that prereq course
  prereq_courses = {}
  paths = []

  input.each do |prereq, course|
    if prereq_courses[prereq]
      prereq_courses[prereq] << course
    else
      prereq_courses[prereq] = [course]
    end
  end

  paths = all_paths_from_roots(roots, prereq_courses)
  
  mid_courses = paths.map do |path|
    length = path.length.odd? ? path.length / 2 : (path.length / 2) - 1 
    path[length]
  end

  mid_courses.uniq
end

def all_paths_from_roots(roots, prereq_courses)
  paths = []

  dfs = lambda do |node, path|
    path << node
    nexts = prereq_courses[node]

    if nexts.nil?
      paths << path.dup
    else
      nexts.each do |nxt|
        dfs.call(nxt, path)
      end
    end

    path.pop
  end

  roots.each { |root| dfs.call(root, []) }
  paths
end


# Example 1:
answer_1 = ["Data Structures", "Creative Writing", "Databases", "Intro to Computer Science"]
output_1 = mid_courses(all_courses_1)
puts output_1 == answer_1 ? "✅passes - with the correct mid vals from all course sequence paths; #{output_1}"
  : "❌fails - output is #{output_1}, but should be #{answer_1}"

# Example 2:
all_courses_2 = input = [
  ["A", "B"],
  ["B", "C"],
  ["C", "D"],
  ["D", "E"]
]
answer_2 = ["C"]
output_2 = mid_courses(all_courses_2)
puts output_2 == answer_2 ? "✅passes - with the correct mid vals from all course sequence paths; #{output_2}"
  : "❌fails - output is #{output_2}, but should be #{answer_2}"

# Example 3:
all_courses_3 = [
  ["Math", "Physics"],
  ["Physics", "Chemistry"],
  ["Chemistry", "Biology"]
]
answer_3 = ["Physics"]
output_3 = mid_courses(all_courses_3)
puts output_3 == answer_3 ? "✅passes - with the correct mid vals from all course sequence paths; #{output_3}"
  : "❌fails - output is #{output_3}, but should be #{answer_3}"

# Example 4:
all_courses_4 = [
  ["Introduction to Business", "Accounting I"],
  ["Accounting I", "Accounting II"],
  ["Accounting II", "Corporate Finance"],
  ["Introduction to Business", "Marketing 101"],
  ["Marketing 101", "Digital Marketing"]
]
answer_4 = ["Accounting I", "Marketing 101"]
output_4 = mid_courses(all_courses_4)
puts output_4 == answer_4 ? "✅passes - with the correct mid vals from all course sequence paths; #{output_4}"
  : "❌fails - output is #{output_4}, but should be #{answer_4}"