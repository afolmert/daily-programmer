#!/usr/bin/ruby
 
class Transposition

  def initialize
    gets.to_i.times do
      @string_array ||= []
      @string_array << gets.chomp
    end
  end

  def max_length
    @string_array.max_by{|string| string.length}.length
  end

  def output
    max_length.times do
      puts transpose_output(@string_array)
      transpose_remainder(@string_array)
    end
  end

  def transpose_output(array)
    array.inject(""){|sum, item| item.size > 0 ? sum += item[0] : sum + " " }
  end

  def transpose_remainder(array)
    array.map!{|item| item.size > 0 ? item[1..-1] : item}
  end

end

Transposition.new.output
