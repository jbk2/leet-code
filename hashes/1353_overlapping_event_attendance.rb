require 'byebug'
# You are given an array of events where events[i] = [startDayi, endDayi]. Every event i starts at startDayi and ends at endDayi.
# You can attend an event i at any day d where startDayi <= d <= endDayi. You can only attend one event at any time d.
# Return the maximum number of events you can attend.

# Constraints:
# 1 <= events.length <= 105
# events[i].length == 2
# 1 <= startDayi <= endDayi <= 105

def max_attendances_3(events)
  ordered_events = events.sort_by { |start_day, end_day| [end_day, start_day] }
  max_day = events.flatten.max
  calendar = (0..max_day + 1).to_a
  attendable_event_count = 0
  
  first_free_from = lambda do |day|
    return max_day + 1 if day > max_day

    if calendar[day] != day
      calendar[day] = first_free_from.call(calendar[day])
    end

    calendar[day]
  end
  
  ordered_events.each do |start_day, end_day|
    available_day = first_free_from.call(start_day)
    next unless available_day <= end_day
    calendar[available_day] = first_free_from.call(available_day + 1)
    attendable_event_count += 1
  end
  
  attendable_event_count
end

def max_attendances_1(events)
  ordered_events = events.sort_by { |start_day, end_day| [end_day, start_day] }
  max_day = events.flatten.max
  calendar = (0..max_day + 1).to_a
  attendable_event_count = 0
  
  first_free_from = lambda do |day|
    while calendar[day] != day
      day = calendar[day]
    end
    day
  end
  
  ordered_events.each do |start_day, end_day|
    available_day = first_free_from.call(start_day)
    next unless available_day <= end_day
    calendar[available_day] = first_free_from.call(available_day + 1)
    attendable_event_count += 1
  end
  
  attendable_event_count
end

def max_attendances_1(events)
  ordered_events = events.sort_by { |start_day, end_day| [end_day, start_day] }
  days_taken = Hash.new()
  attendable_event_count = 0

  ordered_events.each do |start_day, end_day|
    attendable_day = (start_day..end_day).find { |day| !days_taken.has_key?(day) }
    next unless attendable_day
    attendable_event_count += 1
    days_taken[attendable_day] = true
  end

  attendable_event_count
end

events = [[1,2],[2,3],[3,4]]
answer = 3
puts max_attendances_3(events)

RSpec.describe ":max_attendances" do
  describe "test 1" do
    # Example 1:
    # Explanation: You can attend all the three events.
    # One way to attend them all is as shown.
    # Attend the first event on day 1.
    # Attend the second event on day 2.
    # Attend the third event on day 3.
    it "returns correct val" do
      events = [[1,2],[2,3],[3,4]]
      answer = 3
      output = max_attendances_3(events)
      expect(output).to eq(answer)
    end
  end
  
  describe "test 2" do
    it "returns correct val" do
      events = [[1,2],[2,3],[3,4],[1,2]]
      answer = 4
      output = max_attendances_3(events)
      expect(output).to eq(answer)
    end
  end
end