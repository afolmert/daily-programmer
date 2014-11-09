#!/usr/bin/ruby

puts "Please supply the input"
instd = gets.chomp
instr = gets.chomp

def str_cammel(instr)
    instr.split(" ").each{|x| print("#{x.capitalize}")}
end

def str_snake(instr)
    puts instr.gsub(/[ ]/,'_')
end

def str_capsnake(instr)
    puts(instr.split(" ").each{|x| x.capitalize!}.join("_"))
end

def convert_from_string(instd,instr)
    case instd
        when "0" then str_cammel(instr)
        when "1" then str_snake(instr)
        when "2" then str_capsnake(instr)
        else puts "Select a valid case type"
    end
end

def convert_to_string(instd,instr)
    case instd
        when "0" then return (instr.split /(?=[A-Z])/).each{|x| x.downcase!}.join(" ")
        when "1" then return instr.gsub(/[_]/,' ')
        when "2" then return instr.split("_").each{|x| x.downcase!}.join(" ")
        else puts "Select a valid case type"
    end
end

if instd.length == 1
    convert_from_string(instd,instr)
elsif instd.length == 3
    instd = instd.split(" ")
    instr = convert_to_string(instd[0],instr)
    convert_from_string(instd[1],instr)
else
    puts("Select a valid case type")
end
