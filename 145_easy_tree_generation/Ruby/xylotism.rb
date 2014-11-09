#!/usr/bin/ruby

input = gets.chomp.split
x = input[0].to_i
y = input[1]
z = input[2]

a=((x-1)/2)
while a >= 0
puts ' '*a + z*(x-(2*a)) + ' '*a
a-=1
end
puts ' '*((x-3)/2) + y*3 + ' '*((x-3)/2)
