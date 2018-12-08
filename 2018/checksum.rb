#!/usr/bin/env ruby


unless ARGV.length > 0
  raise 'No input file provided'
end

input = ARGV[0]

chks = { twos: 0, threes: 0 }

def letter_counts(id)
  letters = {}
  id.each_char do |letter|
    letters[letter.to_sym] = 0 unless letters[letter.to_sym]
    letters[letter.to_sym] += 1
  end
  letters
end

def two?(counts)
  counts.each do |key, count|
    return true if count == 2
  end
  false
end

def three?(counts)
  counts.each do |key, count|
    return true if count == 3
  end
  false
end

ids = File.read(input).lines.map { |l| l.chomp }
ids.each do |id|
  counts = letter_counts(id)
  chks[:twos] += 1 if two?(counts)
  chks[:threes] += 1 if three?(counts)
end

puts "Checksum: #{chks[:twos]} x #{chks[:threes]} = #{chks[:twos] * chks[:threes]}"


def match_id?(id1, id2)
  diff = 0
  (id1.length).times do |idx|
    diff += 1 if id1[idx] != id2[idx]
    return false if diff > 1
  end
  true
end

def matches(id1, id2)
  common = ""
  (id1.length).times do |idx|
    common << id1[idx] if id1[idx] == id2[idx]
  end
  common
end

ids.each_with_index do |id1, idx|
  match = false
  ids[(idx+1)..-1].each do |id2|
    if match_id?(id1, id2)
      puts "Common letters: #{matches(id1, id2)}"
      match = true
      break
    end
  end
  break if match
end
