#!/usr/bin/ruby

OPTS = %w(+ - *)
NUM_OF_OPS  = 3
NUM_OF_INTS = 4

def quit?(input)
  input.downcase.strip == "q"
end

def random_opt
  OPTS[rand(0..OPTS.size-1)]
end

def generate_equation(from, to)
  integers, operators = [], []
  NUM_OF_OPS.times  { operators << random_opt }
  NUM_OF_INTS.times { integers  << rand(from..to) }
  integers.zip(operators).flatten.compact
end

low, high = gets.split
generate_new = true
answer, equation = nil, nil

loop do
  if generate_new
    equation = generate_equation(low.to_i, high.to_i).join(" ")
    answer   = eval(equation)
    generate_new = false
  end

  puts "> #{equation}"
  input = gets
  break if quit?(input)

  if input.to_i == answer
    puts "> Correct!"
    generate_new = true
  else
    puts "> Incorrect..."
  end
end
