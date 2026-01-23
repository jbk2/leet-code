# A website domain "discuss.leetcode.com" consists of various subdomains. At the top level, we have "com", at the next level, we have "leetcode.com" and at the lowest level, "discuss.leetcode.com". When we visit a domain like "discuss.leetcode.com", we will also visit the parent domains "leetcode.com" and "com" implicitly.

# A count-paired domain is a domain that has one of the two formats "rep d1.d2.d3" or "rep d1.d2" where rep is the number of visits to the domain and d1.d2.d3 is the domain itself.

# For example, "9001 discuss.leetcode.com" is a count-paired domain that indicates that discuss.leetcode.com was visited 9001 times.
# Given an array of count-paired domains cpdomains, return an array of the count-paired domains of each subdomain in the input. You may return the answer in any order.

def count_subdomains_orig(domains)
  domain_memo = Hash.new(0)
  
  domains.each do |domain|  
    count, sub_domain = domain.split(' ')
    sub_domain_arr = sub_domain.split('.')
    
    if sub_domain_arr.length == 3
      sub_el, domain_el, tld_el = sub_domain_arr
      domain_url = [domain_el, tld_el].join('.')
      sub_domain_url = [sub_el, domain_el, tld_el].join('.')
      
      domain_memo[domain_url] += count.to_i 
      domain_memo[sub_domain_url] += count.to_i
      domain_memo[tld_el] += count.to_i
      
    elsif sub_domain_arr.length == 2
      domain_el, tld_el = sub_domain_arr
      domain_url = [domain_el, tld_el].join('.')
      
      domain_memo[domain_url] += count.to_i
      domain_memo[tld_el] += count.to_i
    end
  end
  
  domain_count_arr = []
  
  domain_memo.each do |k, v|
    str = v.to_s + ' ' + k
    domain_count_arr << str
  end
  
  domain_count_arr
end

def count_subdomains(domains)
  domain_memo = Hash.new(0)

  domains.each do |domain|
    count, sub_domain = domain.split(' ')

    parts = sub_domain.split('.')

    (0...parts.length).each do |i|
      url = parts[i..].join('.')
      domain_memo[url] += count.to_i
    end
  end

  domain_memo.map{ |k, v| "#{v} #{k}" }
end

# Example 1:
domains_1 = ["9001 discuss.leetcode.com"]
result_1 = ["9001 leetcode.com","9001 discuss.leetcode.com","9001 com"]
test_1 = count_subdomains(domains_1)
puts test_1.tally == result_1.tally ? "✅passes - subdomain list is #{test_1}" : "❌fails - subdomains returned are - #{test_1}, but should be #{result_1}"
# Explanation: We only have one website domain: "discuss.leetcode.com".
# As discussed above, the subdomain "leetcode.com" and "com" will also be visited. So they will all be visited 9001 times.
# Example 2:

domains_2 = ["900 google.mail.com", "50 yahoo.com", "1 intel.mail.com", "5 wiki.org"]
result_2 = ["901 mail.com","50 yahoo.com","900 google.mail.com","5 wiki.org","5 org","1 intel.mail.com","951 com"]
test_2 = count_subdomains(domains_2)
puts test_2.tally == result_2.tally ? "✅passes - subdomain list is #{test_2}" : "❌fails - subdomains returned are - #{test_2}, but should be #{result_2}" # or check with this; result_2.all? { |d| test_2.include?(d) }
# Explanation: We will visit "google.mail.com" 900 times, "yahoo.com" 50 times, "intel.mail.com" once and "wiki.org" 5 times.
# For the subdomains, we will visit "mail.com" 900 + 1 = 901 times, "com" 900 + 50 + 1 = 951 times, and "org" 5 times.