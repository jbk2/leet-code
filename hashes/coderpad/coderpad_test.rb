
require 'json'

# Who is the most prolific author?

def map_authors_posts(data)
  author_posts_count = Hash.new(0)
  posts = data['posts']

  posts.each do |post|
    author_posts_count[post['author']] += 1    
  end

  author_posts_count.sort_by {|k, v| -v }[0][0]
end

def highest_comment_post(data)
  posts = data['posts']
  highest = { id: nil, count: 0}


  posts.each_with_index do |post|
    comments_length = post['comments'].length
    if comments_length > highest[:count]
      highest[:id] = post['id']
      highest[:count] = comments_length
    end
  end

  posts.may_by

  highest
end

#(1..4).max_by {|element| -element }                    # => 1
#%w[a b c d].max_by {|element| -element.ord }           # => "a"
#{foo: 0, bar: 1, baz: 2}.max_by {|key, value| -value } # => [:foo, 0]
#[].max_by {|element| -element }                        # => nil


class BlogAnalyser
  def initialize
    @author_posts = Hash.new(0)

  end
  
  
  def parse_posts(posts)
  
  end

end


File.open("/home/coderpad/data/input.json") do |file|
  json_file = File.read(file)
  data = JSON.parse(json_file)
  puts highest_comment_post(data)
end




# puts author_posts_count

# def posts_count(author)
  
# end

# def post_comments_count(post)
# end

# def


