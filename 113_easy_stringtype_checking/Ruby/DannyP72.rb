#!/usr/bin/env ruby

def type_check(input)
  puts case input
    when /^[+-]?\d+$/ then "int"
    when /^\d+\.+\d+$/ then "float"
    when /^\d+-{1}\d+-{1}\d+$/ then "date"
    else "text"
  end
end
