#!/usr/bin/env ruby


unless ARGV.length > 0
  raise 'No input file given'
end

input = ARGV[0]

claims = {}

File.read(input).split("\n").each do |line|
  tokens = line.split
  id = tokens[0]
  data = {}
  data[:left],  data[:top]    = tokens[2].delete(":").split(',')
  data[:width], data[:height] = tokens[3].split('x')
  claims[id.to_sym] = data
end
require 'pry'
binding.pry
