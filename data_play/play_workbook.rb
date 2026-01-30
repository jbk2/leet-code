events = [
  { user_id: 1, action: "login" },
  { user_id: 2, action: "logout" },
  { user_id: 1, action: "login" },
  { user_id: 3, action: "login" },
  { user_id: 2, action: "login" }
]

def count_logins(events)
  user_logins = Hash.new(0)
  events.each do |event|
    user_logins[event[:user_id]] += 1 if event[:action] == "login"
  end
  user_logins
end

# puts count_logins(events)

policies = [
  { id: 1, premium: 1200, status: "active" },
  { id: 2, premium: 800, status: "inactive" },
  { id: 3, premium: 950, status: "active" }
]


def active_policy_ids_sorted(policies)
  ids_premiums = {}
  
  policies.each do |policy|
    ids_premiums[policy[:id]] = policy[:premium] if policy[:status] =="active"
  end
  ids_premiums.sort_by{ |_, v| -v }.map{ |arr| arr[0] }
end


puts active_policy_ids_sorted(policies).inspect