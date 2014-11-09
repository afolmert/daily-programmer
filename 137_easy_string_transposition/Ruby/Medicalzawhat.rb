#!/usr/bin/ruby

strings = []
buff = ""
n = gets.to_i
n.times {strings << gets.chomp}
i = 0
while strings.grep(/\w/).size > 0
    if !strings[i][0].nil?
        buff << strings[i].slice!(0)
    else 
        buff << " "
    end

    i+=1
    if i >= strings.length
        puts buff
        buff = ""
        i = 0
    end
end
