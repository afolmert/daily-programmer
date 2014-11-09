#!/usr/bin/ruby

def draw_tree(input)
    height, trunk_char, leaf_char = input.split(' ')
    height = height.to_i


    for i in 1..height
        if i % 2 != 0 
            puts (leaf_char * i).center(height)
        end
    end
    puts (trunk_char * 3).center(height)
end



draw_tree("3 # *")
//
draw_tree("13 = +")


draw_tree("5 % ^")

draw_tree("27 % ^")
