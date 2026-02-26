# You have a data structure of employee information, including the employee's unique ID, importance value, and direct subordinates' IDs.
# You are given an array of employees employees where:
# employees[i].id is the ID of the ith employee.
# employees[i].importance is the importance value of the ith employee.
# employees[i].subordinates is a list of the IDs of the direct subordinates of the ith employee.
# Given an integer id that represents an employee's ID, return the total importance value of this employee and all their direct and indirect subordinates.

# Constraints:
# 1 <= employees.length <= 2000
# 1 <= employees[i].id <= 2000
# All employees[i].id are unique.
# -100 <= employees[i].importance <= 100
# One employee has at most one direct leader and may have several subordinates.
# The IDs in employees[i].subordinates are valid IDs.

## Definition for Employee.
class Employee
  attr_accessor :id, :importance, :subordinates
  def initialize( id, importance, subordinates)
      @id = id
      @importance = importance
      @subordinates = subordinates
  end
end

class EmpeeMap
  attr_reader :map
  def initialize(data)
    @map = {}
    populate_tree(data)
  end

  def populate_tree(data)
    data.each do |empee|
      @map[empee[0]] = Employee.new(empee[0], empee[1], empee[2])
    end
  end
end

def get_importance(empee_map, id)
  return nil if !empee_map.map[id]
  visited = Set.new
  importance = 0

  dfs = lambda do |empee_id| 
    return if visited.include?(empee_id)
    
    empee = empee_map.map[empee_id]
    visited.add(empee_id)
    
    importance += empee.importance
    
    empee.subordinates.each { |e| dfs.call(e) }
  end

  dfs.call(id)
  importance
end


# Example 1:
employees_1 = [[1,5,[2,3]],[2,3,[]],[3,3,[]]]
id_1 = 1
answer_1 = 11
map_1 = EmpeeMap.new(employees_1)
output_1 = get_importance(map_1, id_1)
puts output_1 == answer_1 ? "✅ correct - total score of empee id#;#{id_1} is #{output_1}"
: "❌ incorrect - total score of empee id#;#{id_1} shoudl be #{answer_1}, but you gave #{output_1}"
# Explanation: Employee 1 has an importance value of 5 and has two direct subordinates: employee 2 and employee 3.
# They both have an importance value of 3.
# Thus, the total importance value of employee 1 is 5 + 3 + 3 = 11.

# Example 2:
employees_2 = [[1,2,[5]],[5,-3,[]]]
id_2 = 5
answer_2 = -3
map_2 = EmpeeMap.new(employees_2)
output_2 = get_importance(map_2, id_2)
puts output_2 == answer_2 ? "✅ correct - total score of empee id#;#{id_2} is #{output_2}"
: "❌ incorrect - total score of empee id#;#{id_2} should be #{answer_2}, but you gave #{output_2}"
# Explanation: Employee 5 has an importance value of -3 and has no direct subordinates.
# Thus, the total importance value of employee 5 is -3.
 
