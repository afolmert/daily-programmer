#!/usr/bin/env ruby

puts "> Range:"
range = gets.chomp.split.sort
operators = ["+", "-", "*"]
done = false
correct = false

until done do
    v = "(range[0]..range[1]).to_a.sample"
    o = "operators.sample"
    expression = "#{eval(v)} #{eval(o)} #{eval(v)} #{eval(o)} #{eval(v)} #{eval(o)} #{eval(v)}"

    until done or correct do
        puts "> " + expression
        answer = gets.chomp

        if answer.downcase == "q"
            done = true
        elsif answer.to_i == eval(expression)
            puts "> Correct!"
            correct = true
        else
            puts "> Incorrect..."
        end
    end

    if done
        puts "> Goodbye!"
    else
        correct = false
    end
end
