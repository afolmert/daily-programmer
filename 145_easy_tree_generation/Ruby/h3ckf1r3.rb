#!/usr/local/bin/ruby -w

pad = " " * (ARGV[0].to_i/2)
row = ARGV[2]
while pad.size>0
  puts pad + row + pad
  pad.chop!
  row += ARGV[2] * 2
end
puts ARGV[2] * ARGV[0].to_i
puts " " * (ARGV[0].to_i/2-1) + ARGV[1] * 3
