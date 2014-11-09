#!/usr/bin/ruby

puts "Please enter your string:"
input = gets.chomp

puts case input
  when /\d+-\d+-\d+/ then "date"
  when /\d+\.\d+/    then "float"
  when /\d+/         then "int"
  when /[a-z]+/i     then "string"
  else               raise "Invalid String"
end
