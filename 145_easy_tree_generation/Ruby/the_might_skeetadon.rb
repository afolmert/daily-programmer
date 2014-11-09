#!/usr/bin/ruby

input = '77 # *'
width, base, needles = input.split
width = width.to_i
width.times do |deck|
    if (deck + 1).odd? #skip boughs with even numbers of leaves
        bough = (needles * (deck + 1)) #number of leaves = count + 1, since it starts at 0
        puts bough.center(width)
    end
end
puts (base * 3).center(width)


# alternative

ARGV[0].split[0].to_i.times {|x| puts (ARGV[0].split[2] * (x + 1)).center(ARGV[0].split[0].to_i) if x.even? }
puts (ARGV[0].split[1] * 3).center(ARGV[0].split[0].to_i)


