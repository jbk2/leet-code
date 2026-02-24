require 'set'
# Given a list of accounts where each element accounts[i] is a list of strings, where the first element accounts[i][0] is a name,
# and the rest of the elements are emails representing emails of the account. Now, we would like to merge these accounts.
# Two accounts definitely belong to the same person if there is some common email to both accounts.
# Note that even if two accounts have the same name, they may belong to different people as people could have the same name.
# A person can have any number of accounts initially, but all of their accounts definitely have the same name.

# After merging the accounts, return the accounts in the following format: the first element of each account is the name, and the rest of the elements are emails in sorted order. The accounts themselves can be returned in any order.
#
# Constraints:
# 1 <= accounts.length <= 1000
# 2 <= accounts[i].length <= 10
# 1 <= accounts[i][j].length <= 30
# accounts[i][0] consists of English letters.
# accounts[i][j] (for j > 0) is a valid email.

# Implementation Notes:
# merge accounts if - common email && common name
# commons named accounts can be different users

def merge_accounts(accts)
  email_accounts = Hash.new { |h, k| h[k] = [] }
  # merged_accts = accts.dup
  # common_email_and_name_acct_indxs = []
  
  accts.each_with_index do |acct, orig_index|
    acct.each_with_index do |email, idx|
      next if idx == 0
      email_accounts[email].push(orig_index)
    end
  end
  
  # where an email keys values have multiple indexes in its values those multiple acount indexes should become one
  linked_accounts = Hash.new { |h, k| h[k] = [] }
  email_accounts.each_value do |idxs|
    idxs = idxs.uniq
    next if idxs.length < 2    
    first = idxs[0]
    idxs[1..].each do |j|
      linked_accounts[first] << j
      linked_accounts[j] << first
    end
  end
  
  # go through each index 0..n
  # keep a visited memo of 0..n
  # for each index
  #   a) create an account array containing a name hash and an emails hash
  #   b) add the name from accts[index][0] to name hash
  #   c) add the emails from accts[index]
  #   d) look up the values against the index key in linked accounts, for each value:
  #     1) add their emails from accts[index] also
  #     2) look up their values against the index ken in linked accounts, for each value:
  #       ... etc 
  #     3) mark them as visited in memo
  #   e) when everything searched/visited, mark the root index that we iterated from as visited in memo
  #   f) uniq and sort emails, then flatten with name hash into an array of strings and push into merged
  
  n = accts.length
  visited_indexes = Array.new(n, false)
  merged = []
  
  (0...n).each do |index|
    next if visited_indexes[index]
    
    index_cluster = []
    name = accts[index][0]
    emails = Set.new()
    
    dfs = lambda do |i|
      return if visited_indexes[i]
      index_cluster << i
      visited_indexes[i] = true
      
      linked_accounts[i].each do |lnkd_idx|
        dfs.call(lnkd_idx)
      end
    end
    
    if linked_accounts[index] && !visited_indexes[index]
      dfs.call(index)
    end
    
    add_emails = lambda do |i|
      accts[i][1..].each { |email| emails.add(email) }
      visited_indexes[i] = true
    end

    index_cluster.uniq.each { |i| add_emails.call(i) }
    visited_indexes[index] = true
    merged << [name] + emails.to_a.sort
  end

  merged
end

# Time Complexity: m = no_of_emails, ∴ O(m log m)
# Space Complexity n = no of accounts, m = no_of_emails, ∴ O(n + m)

  # OLD CODE
  # (0..accts.length).each do |start_idx|
  #   next if visited_indexes[start_idx]

  #   queue = [start_idx]
  #   queue_idx = 0
  #   visited_indexes[start_idx] = true

  #   name = accts[start_idx][0]
  #   emails = Set.new

  # end

  # linked_accounts
  # email_accounts


  # common_email_accts = email_accounts.reject { |k, v| v.length < 2 }
  
  # common_email_accts.each do |email, orig_indexes|
  #   # e.g. account_indexes = [1, 3, 6]
  #   to_be_merged = []
    
  #   orig_indexes.each_with_index do |orig_idx, i|
  #     j = i + 1
  #     name = accts[orig_idx][0]
  #     while j < orig_indexes.length
  #       comparator_name = accts[orig_indexes[j]][0]
  #       if comparator_name == name
  #         # add both orig indexes to common....
  #         to_be_merged << orig_idx 
  #         to_be_merged << orig_indexes[j]
  #       end
  #       j += 1 
  #     end
  #   end
  #   common_email_and_name_acct_indxs << to_be_merged
  # end

  # common_email_and_name_acct_indxs.each do |orig_indexes|
  #   merged = []
    
  #   orig_indexes.each_with_index do |orig_index, i|  
  #     if i == 0
  #       accts[orig_index].each { |str| merged << str }  
  #     else
  #       accts[orig_index].each_with_index { |str, idx| merged << str unless idx == 0 }  
  #     end

  #     merged_accts[orig_index] = nil
  #   end
    
  #   name = merged[0]
  #   emails = merged[1..].uniq.sort
  #   merged_accts << [name, *emails]
  # end

  # merged_accts.compact.map { |acct| [acct[0], *acct[1..].uniq.sort] }

# Example 1:
key = ->(acct) { [acct[0], acct[1..].join("|")] }
accounts_1 = [["John","johnsmith@mail.com","john_newyork@mail.com"],["John","johnsmith@mail.com","john00@mail.com"],["Mary","mary@mail.com"],["John","johnnybravo@mail.com"]]
answer_1 = [["John","john00@mail.com","john_newyork@mail.com","johnsmith@mail.com"],["Mary","mary@mail.com"],["John","johnnybravo@mail.com"]]
output_1 = merge_accounts(accounts_1)
puts output_1.sort_by(&key) == answer_1.sort_by(&key) ? "✅ yes accounts have been merged correctly correct majority count is #{output_1}"
  :
  "❌ no, incorrect merging, accounts should be => #{answer_1}, \n\n but instead are => #{output_1}"
# Explanation:
# The first and second John's are the same person as they have the common email "johnsmith@mail.com".
# The third John and Mary are different people as none of their email addresses are used by other accounts.
# We could return these lists in any order, for example the answer [['Mary', 'mary@mail.com'], ['John', 'johnnybravo@mail.com'], 
# ['John', 'john00@mail.com', 'john_newyork@mail.com', 'johnsmith@mail.com']] would still be accepted.

# Example 2:
accounts_2 = [["Gabe","Gabe0@m.co","Gabe3@m.co","Gabe1@m.co"],["Kevin","Kevin3@m.co","Kevin5@m.co","Kevin0@m.co"],["Ethan","Ethan5@m.co","Ethan4@m.co","Ethan0@m.co"],["Hanzo","Hanzo3@m.co","Hanzo1@m.co","Hanzo0@m.co"],["Fern","Fern5@m.co","Fern1@m.co","Fern0@m.co"]]
answer_2 = [["Ethan","Ethan0@m.co","Ethan4@m.co","Ethan5@m.co"],["Gabe","Gabe0@m.co","Gabe1@m.co","Gabe3@m.co"],["Hanzo","Hanzo0@m.co","Hanzo1@m.co","Hanzo3@m.co"],["Kevin","Kevin0@m.co","Kevin3@m.co","Kevin5@m.co"],["Fern","Fern0@m.co","Fern1@m.co","Fern5@m.co"]]
output_2 = merge_accounts(accounts_2)
puts output_2.sort_by(&key) == answer_2.sort_by(&key) ? "✅ yes accounts have been merged correctly correct majority count is #{output_2}" : "❌ no, incorrect merging, accounts should be => #{answer_2},\n\n but instead are => #{output_2}" 
