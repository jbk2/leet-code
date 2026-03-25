# A transaction is possibly invalid if:
# - the amount exceeds $1000, or;
# - if it occurs within (and including) 60 minutes of another transaction with the same name in a different city.
# you are given an array of strings transaction where transactions[i] consists of comma-separated values representing the name, time (in minutes), amount, and city of the transaction.

# Return a list of transactions that are possibly invalid. You may return the answer in any order.

# Constraints:
# transactions.length <= 1000
# Each transactions[i] takes the form "{name},{time},{amount},{city}"
# Each {name} and {city} consist of lowercase English letters, and have lengths between 1 and 10.
# Each {time} consist of digits, and represent an integer between 0 and 1000.
# Each {amount} consist of digits, and represent an integer between 0 and 2000.

# Approach
# process data into hashmap with key of name value an array of transactions
# [name: [city_name: [{time: Time, ammount: Number}, {time: Time, ammount: Number}], city_name: [{time: Time, ammount: Number}, {time: Time, ammount: Number}]]]
#   if transaciton value >= 1000 add to invalids
#   if hash[name] already exists && does hash[name][city] already exist, if so citys match && time within 60mins add both to invalids

def invalids(data)
  invalid_ids = Set.new
  transactions = Hash.new { |hash, name| hash[name] = [] }

  add_time_location_invalids = lambda do |transactions, transaction, i|
    name, time, ammount, city = transaction.split(',')

    invalid_transactions = transactions[name].select do |t|
      t[:city] != city && (t[:time] - 60..t[:time] + 60).include?(time.to_i)
    end
    
    unless invalid_transactions.empty?

      invalid_transactions.each do |t|
        invalid_ids.add(t[:orig_index])
      end
      invalid_ids.add(i)
    end
  end

  data.each_with_index do |transaction, i|
    name, time, ammount, city = transaction.split(',')
    
    transactions[name] << { city: city, time: time.to_i, ammount: ammount.to_i, orig_index: i }
    
    invalid_ids.add(i) if ammount.to_i >= 1000

    add_time_location_invalids.call(transactions, transaction, i)
  end

  invalid_ids.map { |i| data[i] }
end


def invalid_transactions(data)
  # map transactions by name with values as an array of transaction times (or ranges maybe)
  # iterate over trnsactions and evaluate against
  #  - > 1000
  #  - and look up name in map and if present inspect transactions for a value tim - 60 or time + 60
  map = Hash.new{ |h, k| h[k] = [] }
  invalids = []

  data.each do |t|
    trans = t.split(',')
    transaction = { time: trans[1].to_i, price: trans[2].to_i, city: trans[3], t_string: t } 
    if transaction[:price] > 1000
      invalids << t
      next
    end
    name = trans[0]
    map[name] << transaction
  end

  data.each do |t|
    trans = t.split(',')
    name = trans[0]; time = trans[1]; price = trans[2].to_i; city = trans[3]; t_string = t;    
    users_transactions = map[name]
    
    users_transactions.each do |transaction|
      same_city = transaction[:city] == city
      within_60_mins = Range.new(transaction[:time] - 60, transaction[:time] + 60).include?(time)
      if same_city && within_60_mins
          #  if yes delete from map and add to invalids
        invalids << t
        map[name].delete_if { |el| el.t_string == t } # must add both transactions and delete from map
      end
    end
  
  end
  
  invalids
end




# Example 1:
transactions_1 = ["alice,20,800,mtv","alice,50,100,beijing"]
answer_1 = ["alice,20,800,mtv","alice,50,100,beijing"]
output_1 = invalids(transactions_1)
# puts invalids(transactions_1).inspect
puts output_1 == answer_1 ? "✅ correct - invalid transactions were #{output_1}" : "❌ incorrect - invalid transactions shoudl be #{answer_1}, not #{output_1}"
# Explanation: The first transaction is invalid because the second transaction occurs within a difference of 60 minutes, have the same name and is in a different city. Similarly the second one is invalid too.

# Example 2:
transactions_2 = ["alice,20,800,mtv","alice,50,1200,mtv"]
answer_2 = ["alice,50,1200,mtv"]
output_2 = invalids(transactions_2)
puts output_2 == answer_2 ? "✅ correct - invalid transactions were #{output_2}" : "❌ incorrect - invalid transactions shoudl be #{answer_2}, not #{output_2}"

# Example 3:
transactions_3 = ["alice,20,800,mtv","bob,50,1200,mtv"]
answer_3 = ["bob,50,1200,mtv"]
output_3 = invalids(transactions_3)
puts output_3 == answer_3 ? "✅ correct - invalid transactions were #{output_3}" : "❌ incorrect - invalid transactions shoudl be #{answer_3}, not #{output_3}"