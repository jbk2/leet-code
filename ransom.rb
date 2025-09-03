ransom_note1 = "a"
magazine1 = "b"

ransom_note2 = "aa"
magazine2 = "ab"

ransom_note3 = "aa"
magazine3 = "aab"

def can_construct(ransom_note, magazine)
  library = Hash.new(0)
  magazine.each_char { |ch| library[ch] += 1 }

  ransom_note.each_char do |ch|
    return false if (library[ch] -= 1).negative?
  end

  true
end

puts can_construct(ransom_note1, magazine1).inspect