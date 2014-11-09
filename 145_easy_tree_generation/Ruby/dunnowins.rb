#!/usr/bin/ruby

chars = gets.chomp.split
dist = chars[0].to_i
base = chars[1]
body = chars[2]

def make_space(dist, quantity, char)
  space = (dist - quantity)/2
  ' ' * space + char*quantity
end

1.upto(dist) do |x|
  if x.odd?
    puts make_space(dist, x, body)
  end
end

puts make_space(dist, 3, base)
