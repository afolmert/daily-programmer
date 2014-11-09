#!/usr/bin/ruby

def to_put (string)
    arr = string.split(/\n/)
    arr.delete_at(0)

    y = arr.sort { |x, y| y.length <=> x.length } #Finds the longest word and places it first in array y
    arr.each do |x|
        x << " " * (y[0].length - x.length)
    end

    final = String.new

    for i in 1..y[0].length
        arr.each do |x|
            final << x[i]
        end
        final << "\n"

    end

    puts final
end
