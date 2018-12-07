#!/usr/bin/env ruby


unless ARGV.length > 0
  raise 'No input file given'
end

freq_file = ARGV[0]

frequency = 0
File.read(freq_file).each_line { |l| frequency += l.to_i }

puts "Final frequency: #{frequency}"
