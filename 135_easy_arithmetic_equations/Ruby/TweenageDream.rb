#!/usr/bin/ruby

OPERATORS = ["*", "-", "+"]
ints = Range.new(*gets.chomp.split(" ").map(&:to_i)).to_a
input, make_new = "", true
until input.downcase == "q" do
    eq = 4.times.reduce(""){|str|"#{str} #{ints.sample} #{OPERATORS.sample} "}.chop.chop if make_new
    ans = eval eq
    puts "> #{eq}"
    input = gets.chomp
    next if input.downcase == "q"
    if input.to_i == ans
        make_new = true
        puts "> Correct!"
    else
        make_new = false
        puts "> incorrect..."
    end
end
