#!/usr/bin/ruby

n, b, t = gets.split()
n = n.to_i

for i in 0..n do
  puts ' '*((n-i)/2) + t*i unless i.even?
end

puts ' '*((n-3)/2) + b*3 + ' '*((n-3)/2)
