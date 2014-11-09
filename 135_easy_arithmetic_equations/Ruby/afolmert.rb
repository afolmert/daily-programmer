#!/usr/bin/ruby

module Operand 
    MULTIPLY = 0
    MINUS = 1
    PLUS = 2
    NONE = 3
end

class Expression
    # input: original text
    # left: left side expression
    # right: right side expression
    # operand: operand 
    def initialize(input, left, right, operand)
        @input = input
        @left = left
        @right = right
        @operand = operand
    end

    def solve
        if @operand == Operand::PLUS
            return @left.solve + @right.solve
        elsif @operand == Operand::MINUS
            return @left.solve - @right.solve
        elsif @operand == Operand::MULTIPLY
            return @left.solve * @right.solve
        else
            fail("Expected operand NONE and not #{@operand}") if @operand != Operand::NONE
            fail("Expected left nil and not #{@left}") if @left != nil
            fail("Expected right nil and not #{@right}") if @right != nil
            return @input.strip.to_i
        end
    end

    def to_s
        return @input
    end
end




class CodeKata
    @@operands = ["+", "-", "*"]



    def initialize(min_number = 1, max_number = 10, eq_length = 4) 
        @min_number = min_number
        @max_number = max_number
        @eq_length = eq_length
    end


    # Returns Expression object 
    def parse_expression(input)
        # scan for * 
        if input =~ /\+/
            return Expression.new(input, parse_expression($`), parse_expression($'), Operand::PLUS)
        elsif input =~ /-/
            left = parse_expression($`)
            right = parse_expression(switch_plus_and_minus($'))
            return Expression.new(input, left, right, Operand::MINUS)
        elsif input =~ /\*/
            return Expression.new(input, parse_expression($`), parse_expression($'), Operand::MULTIPLY)
        else
            return Expression.new(input, nil, nil, Operand::NONE) 
        end
    end


    def generate_equation

        result = ""

        for i in 0...@eq_length - 1
            result += random_number.to_s
            result += " "
            result += random_operator
            result += " "
        end
        result += random_number.to_s
        return result
    end

    def solve_equation(equation)
        expr = parse_expression(equation)
        return expr.solve
    end

    def run
        puts "Calculate following equations: " 
        while true 
            eq = generate_equation
            puts eq
            print "> " 
            given = gets.chomp
            expected = solve_equation(eq).to_s

            if given == expected
                puts "Correct!"
            else
                puts "Incorrect... should be #{expected}"
            end
        end
    end

    private

    def switch_plus_and_minus(input)
        return input.gsub(/[\+-]/) { |x| x == '+' ? '-' : '+' }
    end

    def random_operator
        return @@operands.sample
    end

    def random_number
        return Random.new.rand(@min_number..@max_number)
    end

end


def test
    puts "Hello world!"

    puts RUBY_VERSION


    puts "Input arithemtic equation: " 

    equation = gets

    puts "You entered equation #{equation}"

end



def test_solve
    for i in 1..1000
        eq = codekata.generate_equation
        puts eq
        eval_res = eval(eq)
        kata_res = codekata.solve_equation(eq)
        if eval_res != kata_res
            fail "ERROR for #{eq}"
        else
            puts "OK for #{eq}: #{eval_res}, #{kata_res}"
        end
        puts "======="
    end
end


def main
    codekata = CodeKata.new(1, 10, 4)
    codekata.run
end


main
