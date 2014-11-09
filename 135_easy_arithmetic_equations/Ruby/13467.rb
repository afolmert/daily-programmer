#!/usr/bin/ruby

$ops = %w(+ - *)
$nums = Range.new(*gets.split.map(&:to_i)).to_a

def random_expr
  expr = "#{$nums.sample}"
  3.times { expr << " #{$ops.sample} #{$nums.sample}" }
  return expr
end

loop do
  puts (expr = random_expr)
  break unless (input = gets) =~ /^\d+/
  puts case input.to_i == eval(expr)
    when false then "Try again."
    when true  then "Correct!"
  end
end
