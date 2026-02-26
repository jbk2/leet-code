require 'json'
data = JSON.parse(File.read("scrimba-podcast-data.json"));


def sort_by_duration(data, flight_duration)
  dir = flight_duration <= 60 ? 1 : -1
  data.sort_by { |pod| dir * pod['duration'] }
end

puts sort_by_duration(data, 60)