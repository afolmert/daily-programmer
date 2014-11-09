#!/usr/bin/ruby

OPS = %w(+ - *)

def generate_number
  return (2 + rand(8)).to_s
end

def generate_operator
  return OPS[rand(OPS.length)]
end

def generate_equation
  equation_length = 2 + rand(3)
  equation_ops = []
  equation_numbers = [] << generate_number

  (equation_length - 1).times {
    equation_ops << generate_operator
    equation_numbers << generate_number
  }

  equation = equation_numbers.each_with_index
    .flat_map { |x, idx| (idx < equation_length - 1) ? [x, equation_ops[idx]] : [x] }
      .join(" ")

  return equation, eval(equation)
end

equation, result = generate_equation

while(true) do
  p equation
  asnwer = gets.chomp

  p "Bye!" and break if asnwer.downcase == "q"
  p "Incorrect!" and next if asnwer.to_i != result
  p "Correct!"

  equation, result = generate_equation
end
