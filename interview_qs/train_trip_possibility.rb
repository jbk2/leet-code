require 'byebug'
# A friend of yours is planning a trip across the country via train, but they can't read the train information!
# They've asked you to help and they want you to check if they can get from place to place on the rail network.
# You hit a snag while trying to help when you've found that the trains don't always return to a station they've departed from!
# That is to say that a train route might go from Station X to Station Y, but it might not go from Station Y to Station X.

# They love train trips so they don't care how many trains it takes as long as it's possible to reach their target destination.
# You've decided to write a program to help you with the job and the format you've decide to use is as follows:

# check_trip(start, target, stations, station_links)

# You want the method to return "Trip is Possible" if the trip is possible and "Trip is impossible" if otherwise


def check_trip(start, target, stations, station_links)
  return "invalid target or stations" if !stations.include?(start) || !stations.include?(target)
  return "Trip is Possible" if start == target
  
  visited = Set.new

  target_found = lambda do |station|
    return true if station == target
    
    stops_arr = station_links[station]
    return false if stops_arr.nil? || stops_arr.empty?

    stops_arr.each do |stop|
      next if visited.include?(stop)
      visited.add(stop)

      return true if target_found.call(stop)
    end
    false
  end

  target_found.call(start) ? "Trip is Possible" : "Trip is impossible"
end

RSpec.describe ":check_trip" do
  describe "evaluates the possibility of the given route correctly" do
    let(:stations) { ["ADL", "BRI", "MEL", "SYD"] }
    let(:links) { { "ADL" => ["MEL"], "MEL" => ["ADL", "SYD"], "SYD" => ["BRI"] } }
    it "test 1" do
      output = check_trip("ADL", "BRI", stations, links)
      answer = "Trip is Possible"
      expect(output).to eq(answer)
    end
    it "test 2" do
      output = check_trip("MEL", "BRI", stations, links)
      answer = "Trip is Possible"
      expect(output).to eq(answer)
    end
    it "test 1" do
      output = check_trip("SYD", "ADL", stations, links)
      answer = "Trip is impossible"
      expect(output).to eq(answer)
    end
  end
end