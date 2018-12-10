#!/usr/bin/env ruby


unless ARGV.length > 0
  raise 'No input file given'
end

input = ARGV[0]
@verbose = ARGV[1] == '-v'


polymer = File.read(input).strip

def count_pairs(chem)
  counts = {}
  chem.each_char do |ch|
    counts[ch.downcase.to_sym] ||= 0
    counts[ch.downcase.to_sym] += 1
  end
  counts
end

def max(hsh)
  ch = nil
  count = nil
  hsh.each_pair do |key, value|
    ch ||= key.to_s
    count ||= value
    if value > count
      ch = key.to_s
      count = value
    end
  end
  ch
end

def react(chem)
  loop do
    left = ''
    newchem = false
    idx = 0
    loop do
      if idx >= chem.length
        break
      elsif idx + 1 == chem.length
        left << chem[idx]
        break
      elsif chem[idx] == chem[idx + 1] || chem[idx].downcase != chem[idx + 1].downcase
        unless idx && chem[idx]
          require 'pry'
          binding.pry
        end
        left << chem[idx]
      else
        newchem = true
        idx += 1
      end
      idx += 1
    end
    return left unless newchem
    puts "newchem: #{left}" if @verbose
    chem = left
  end
end

shortest = nil
final_chem = nil
('a'..'z').to_a.each do |ch|
  new_poly = polymer.delete("#{ch.downcase}#{ch.upcase}")
  chem = react(new_poly)
  final_chem ||= chem
  shortest ||= chem.length
  if chem.length < shortest
    shortest = chem.length
    final_chem = chem
  end
end

puts "Final chemical:\n-----\n#{final_chem}\n-----"
puts "Contains: #{final_chem.length} units"
