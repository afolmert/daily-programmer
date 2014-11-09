#!/usr/bin/ruby

x,y = gets.chomp.split
r=*(x..y)
ops = [:+, :-, :*]
i = String.new
until i == "q"
  eq = %{#{r.sample} #{ops.sample} #{r.sample} #{ops.sample} #{r.sample} #{ops.sample} #{r.sample}}
  puts eq
  i = gets.chomp!
  eval(eq) == i.to_i ? puts "Correct!" : puts "Incorrect!"
end
