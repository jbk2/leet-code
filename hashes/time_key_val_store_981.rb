# Design a time-based key-value data structure that can store multiple values for the same key at different time stamps and retrieve
# the key's value at a certain timestamp.

# Implement the TimeMap class:
# TimeMap() Initializes the object of the data structure.
# set(key, value, timestamp) Stores the key key with the value value at the given time timestamp.
# get(key,timestamp) Returns a value such that set was called previously, with timestamp_prev <= timestamp.
  # If there are multiple such values, it returns the value associated with the largest timestamp_prev. If there are no values, it returns "".
 
# Constraints:
# 1 <= key.length, value.length <= 100
# key and value consist of lowercase English letters and digits.
# 1 <= timestamp <= 107
# All the timestamps timestamp of set are strictly increasing.
# At most 2 * 105 calls will be made to set and get.

class TimeMap
  def initialize
    @map = Hash.new { |h, k| h[k] = [] } # {string: [time, val]}
  end

  def set(key, val, time)
    @map[key] << [time, val]
  end

  def get(key, time)
    val_arr = @map[key]
    return "" if val_arr.empty?

    # recursive approach
    # upper_bound = lambda do |time, arr, lo = 0, hi = arr.length|
    #   return lo if lo >= hi
    #   mid = (lo + hi) / 2

    #   if arr[mid][0] <= time
    #     upper_bound.call(time, arr, mid + 1, hi)
    #   else 
    #     upper_bound.call(time, arr, lo, mid)
    #   end
    # end

    # iterative aproach
    upper_bound = lambda do |time, arr|
      lo = 0
      hi = arr.length
    
      while lo < hi
        mid = (lo + hi) / 2
        if arr[mid][0] <= time
          lo = mid + 1
        else
          hi = mid
        end
      end
      
      lo
    end

    above = upper_bound.call(time, val_arr)
    
    return "" if above == 0
    return val_arr[above - 1][1]
  end

  

  def populate_map(functions, data)
    output = []

    functions.each_with_index do |fn, i|
      case fn
      when "TimeMap"
        output << nil
      when "set"
        set(*data[i])
        output << nil
      when "get"
        output << get(*data[i])
      end
    end
    output
  end
end




# Example 1:
# Input
functions_1 = ["TimeMap", "set", "get", "get", "set", "get", "get"]
data_1 = [[], ["foo", "bar", 1], ["foo", 1], ["foo", 3], ["foo", "bar2", 4], ["foo", 4], ["foo", 5]]
answer_1 = [nil, nil, "bar", "bar", nil, "bar2", "bar2"]
map_1 = TimeMap.new
output_1 = map_1.populate_map(functions_1, data_1)
puts output_1 == answer_1 ? "✅ time map built correctly" : "❌ time map built incorrectly, should output=> #{answer_1}, instead it outputs=> #{output_1}"
# Explanation
# TimeMap timeMap = new TimeMap();
# timeMap.set("foo", "bar", 1);  // store the key "foo" and value "bar" along with timestamp = 1.
# timeMap.get("foo", 1);         // return "bar"
# timeMap.get("foo", 3);         // return "bar", since there is no value corresponding to foo at timestamp 3 and timestamp 2, then the only value is at timestamp 1 is "bar".
# timeMap.set("foo", "bar2", 4); // store the key "foo" and value "bar2" along with timestamp = 4.
# timeMap.get("foo", 4);         // return "bar2"
# timeMap.get("foo", 5);         // return "bar2"
 

