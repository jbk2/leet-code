# You are given an array of events where events[i] = [startDayi, endDayi]. Every event i starts at startDayi and ends at endDayi.
# You can attend an event i at any day d where startDayi <= d <= endDayi. You can only attend one event at any time d.
# Return the maximum number of events you can attend.

# Constraints:
# 1 <= events.length <= 105
# events[i].length == 2
# 1 <= startDayi <= endDayi <= 105
 

def max_attendances(events)
  attendable_event_count = 0
  ordered_events = events.sort_by { |start_day, end_day| [end_day, start_day] }
  min_day, max_day = events.flatten.min, events.flatten.max
  days_taken = (min_day..max_day).to_h { |day| [day, false] }

  ordered_events.each do |start_day, end_day|
    (start_day..end_day).each do |day|
      if days_taken[day] == false
        attendable_event_count += 1
        days_taken[day] = true
        break
      end
    end
  end

  attendable_event_count
end

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
      output = max_attendances(events)
      expect(output).to eq(answer)
    end
  end
  
  describe "test 2" do
    it "returns correct val" do
      events = [[1,2],[2,3],[3,4],[1,2]]
      answer = 4
      output = max_attendances(events)
      expect(output).to eq(answer)
    end
  end
end