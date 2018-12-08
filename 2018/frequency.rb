#!/usr/bin/env ruby


unless ARGV.length > 0
  raise 'No input file given'
end

freq_file = ARGV[0]
verbose = ARGV[1] == '-v'

frequency = 0
frequencies = []
twice = nil

iterations = 0
data = File.read(freq_file).split("\n").map { |l| l.to_i }
loop do
  break if twice
  data.each do |change|
    cur = frequency
    frequency += change
    unless twice
      iterations += 1
      twice = frequency if frequencies.include?(frequency)
    end
    frequencies << frequency
    puts "Current frequency #{cur}, change of #{change}; resulting frequency #{frequency}" if verbose
    puts "twice: #{twice}" if verbose
    break if twice
  end
end

puts "Final frequency: #{frequency}"
puts "First frequency to reach twice: #{twice} (#{iterations})"
