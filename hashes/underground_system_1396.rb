# An underground railway system is keeping track of customer travel times between different stations.
# They are using this data to calculate the average time it takes to travel from one station to another.

# Implement the UndergroundSystem class:

# checkIn(id, stationName, time)
# A customer with a card ID equal to id, checks in at the station stationName at time t.
# A customer can only be checked into one place at a time.

# checkOut(id, stationName, time)
# A customer with a card ID equal to id, checks out from the station stationName at time t.

# getAverageTime(startStation, endStation)
# Returns the average time it takes to travel from startStation to endStation.
# The average time is computed from all the previous traveling times from startStation to endStation that happened directly,
# meaning a check in at startStation followed by a check out from endStation.

# The time it takes to travel from startStation to endStation may be different from the time it takes to travel from endStation to startStation.
# There will be at least one customer that has traveled from startStation to endStation before getAverageTime is called.
# You may assume all calls to the checkIn and checkOut methods are consistent. If a customer checks in at time t1 then checks out at time t2, then t1 < t2.
# All events happen in chronological order.

# Constraints:
# 1 <= id, t <= 106
# 1 <= stationName.length, startStation.length, endStation.length <= 10
# All strings consist of uppercase and lowercase English letters and digits.
# There will be at most 2 * 104 calls in total to checkIn, checkOut, and getAverageTime.
# Answers within 10-5 of the actual value will be accepted.
class Journey
  attr_reader :check_in_station, :check_in_time, :user_id, :duration, :complete, :check_out_station, :check_out_time

  def initialize(user_id, check_in_station, check_in_time)
    @user_id = user_id
    @check_in_station = check_in_station
    @check_in_time = check_in_time
    @check_out_station = nil
    @check_out_time = nil
    @duration = nil
    @complete = false
  end

  def complete(station, time)
    @check_out_station = station
    @check_out_time = time
    @duration = time - check_in_time
    @complete = true
  end
end

class UndergroundSystem
  def initialize
    @incomplete_journeys = {} # hashes with user id as key and Journey instances as value
    @completed_journeys = {} # hashes elements like; {'check_in_station_name'-'check_out_station_name':  Journey }
    @journey_times = Hash.new {|h, k| h[k] = [0, 0]}  # {'check_in_station_name'-'check_out_station_name': [total_time, journey count] }
  end

  def check_in(user_id, stationName, time)
    journey = Journey.new(user_id, stationName, time)
    @incomplete_journeys[user_id] = journey
  end

  def check_out(user_id, stationName, time)
    journey = @incomplete_journeys.delete(user_id)
    journey.complete(stationName, time)
    journey_key = "#{journey.check_in_station}-#{journey.check_out_station}"
    @completed_journeys[journey_key] = journey
    @journey_times[journey_key][0] += journey.duration
    @journey_times[journey_key][1] += 1
  end
   
  def get_average_time(start_station, end_station)
    journey_key = "#{start_station}-#{end_station}"
    total_time = @journey_times[journey_key][0]
    journey_count = @journey_times[journey_key][1]

    average = total_time.to_f / journey_count
    average.round(5)
  end

  def populate_system(event_types, event_data)
    output = []
    
    event_types.each_with_index do |event_type, i|
      
      case event_type
      when "UndergroundSystem"
        output << nil
      when "checkIn"
        check_in(*event_data[i])
        output << nil
      when "checkOut"
        check_out(*event_data[i])
        output << nil
      when "getAverageTime"
        output << get_average_time(*event_data[i])
      end

    end
    output
  end

end



# Example 1:
event_types_1 = ["UndergroundSystem","checkIn","checkIn","checkIn","checkOut","checkOut","checkOut","getAverageTime","getAverageTime","checkIn","getAverageTime","checkOut","getAverageTime"]
events_1 = [[],[45,"Leyton",3],[32,"Paradise",8],[27,"Leyton",10],[45,"Waterloo",15],[27,"Waterloo",20],[32,"Cambridge",22],["Paradise","Cambridge"],["Leyton","Waterloo"],[10,"Leyton",24],["Leyton","Waterloo"],[10,"Waterloo",38],["Leyton","Waterloo"]]
answer_1 = [nil,nil,nil,nil,nil,nil,nil,14.00000,11.00000,nil,11.00000,nil,12.00000]
tube_1 = UndergroundSystem.new
output_1 = tube_1.populate_system(event_types_1, events_1)
puts output_1 == answer_1 ? "✅ class build correctly" :
"❌ class built incorrectly, should output=> #{answer_1}, instead it outputs=> #{output_1}"

# Explanation
# UndergroundSystem undergroundSystem = new UndergroundSystem();
# undergroundSystem.checkIn(45, "Leyton", 3);
# undergroundSystem.checkIn(32, "Paradise", 8);
# undergroundSystem.checkIn(27, "Leyton", 10);
# undergroundSystem.checkOut(45, "Waterloo", 15);  // Customer 45 "Leyton" -> "Waterloo" in 15-3 = 12
# undergroundSystem.checkOut(27, "Waterloo", 20);  // Customer 27 "Leyton" -> "Waterloo" in 20-10 = 10
# undergroundSystem.checkOut(32, "Cambridge", 22); // Customer 32 "Paradise" -> "Cambridge" in 22-8 = 14
# undergroundSystem.getAverageTime("Paradise", "Cambridge"); // return 14.00000. One trip "Paradise" -> "Cambridge", (14) / 1 = 14
# undergroundSystem.getAverageTime("Leyton", "Waterloo");    // return 11.00000. Two trips "Leyton" -> "Waterloo", (10 + 12) / 2 = 11
# undergroundSystem.checkIn(10, "Leyton", 24);
# undergroundSystem.getAverageTime("Leyton", "Waterloo");    // return 11.00000
# undergroundSystem.checkOut(10, "Waterloo", 38);  // Customer 10 "Leyton" -> "Waterloo" in 38-24 = 14
# undergroundSystem.getAverageTime("Leyton", "Waterloo");    // return 12.00000. Three trips "Leyton" -> "Waterloo", (10 + 12 + 14) / 3 = 12

# Example 2:
event_types_2 = ["UndergroundSystem","checkIn","checkOut","getAverageTime","checkIn","checkOut","getAverageTime","checkIn","checkOut","getAverageTime"]
events_2 = [[],[10,"Leyton",3],[10,"Paradise",8],["Leyton","Paradise"],[5,"Leyton",10],[5,"Paradise",16],["Leyton","Paradise"],[2,"Leyton",21],[2,"Paradise",30],["Leyton","Paradise"]]
answer_2 = [nil,nil,nil,5.00000,nil,nil,5.50000,nil,nil,6.66667]
tube_2= UndergroundSystem.new
output_2 = tube_2.populate_system(event_types_2, events_2)
puts output_2 == answer_2 ? "✅ class build correctly" :
"❌ class built incorrectly, should output=> #{answer_2}, instead it outputs=> #{output_2}"
# Explanation
# UndergroundSystem undergroundSystem = new UndergroundSystem();
# undergroundSystem.checkIn(10, "Leyton", 3);
# undergroundSystem.checkOut(10, "Paradise", 8); // Customer 10 "Leyton" -> "Paradise" in 8-3 = 5
# undergroundSystem.getAverageTime("Leyton", "Paradise"); // return 5.00000, (5) / 1 = 5
# undergroundSystem.checkIn(5, "Leyton", 10);
# undergroundSystem.checkOut(5, "Paradise", 16); // Customer 5 "Leyton" -> "Paradise" in 16-10 = 6
# undergroundSystem.getAverageTime("Leyton", "Paradise"); // return 5.50000, (5 + 6) / 2 = 5.5
# undergroundSystem.checkIn(2, "Leyton", 21);
# undergroundSystem.checkOut(2, "Paradise", 30); // Customer 2 "Leyton" -> "Paradise" in 30-21 = 9
# undergroundSystem.getAverageTime("Leyton", "Paradise"); // return 6.66667, (5 + 6 + 9) / 3 = 6.66667