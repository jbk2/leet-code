require 'json'
podcasts = JSON.parse(File.read('./scrimba-podcast-data.json'))

def generate_description(data)
  data.map do |podcast|
    description = "#{podcast['title']} is a #{podcast['duration']} minute #{podcast['genre']} podcast hosted by #{podcast['hosts'][0]}."
    podcast['description'] = description
    podcast
  end
end

puts generate_description(podcasts).inspect