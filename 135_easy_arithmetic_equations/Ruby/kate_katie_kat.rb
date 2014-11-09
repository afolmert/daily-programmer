#!/usr/bin/ruby

class Output
  def initialize
     @range = gets.chomp.split(/ /).map!{|n| n.to_i}
  end

  def random_number
    rand(@range[0]..@range[1])
  end

  def random_operator
    [:+, :-, :*].sample
  end

  def equation
    eq = "#{random_number}"
    3.times {eq << " #{random_operator} #{random_number}"}
    eq
  end
end

class Game
  def initialize
    @output = Output.new
  end

  def play
    while true
      question = @output.equation
      evaluate_question(question)
    end
  end

  def evaluate_question(question)
    puts question
    answer = gets.chomp
    if answer.downcase == 'q'
      exit
    elsif answer.chomp.to_i == eval(question)
      puts "Correct!"
    else
      puts "Try again!"
      evaluate_question(question)
    end
  end
end

Game.new.play
