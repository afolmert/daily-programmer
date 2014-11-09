#!/usr/bin/ruby

def draw_tree (base, trunk_symbol, leaf_symbol)

  for branch in (1..base).step(2)
    puts "#{' ' * ((base - branch)/2)}#{leaf_symbol * branch}"
  end

  puts "#{' ' * (base/2.to_i - 1)}#{trunk_symbol * 3}"   
end

draw_tree(9, '#', '*')
