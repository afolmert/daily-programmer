#!/usr/bin/ruby 

# ver 1

while !(line=gets).nil? do 
    if line.strip=="" then 
        puts ""
        next
    end
    puts type = line.to_i
    start = gets
    case type
    when 0
        puts start.split(" ").inject(""){|sum,word| sum +=word.capitalize}
    when (1..2)
        out = start.split(" ").inject(""){|sum,word| sum +=word+"_"}.chop!
        puts type == 2?out.upcase! : out
    end
end

# ver 2 

type,goal = gets.split (" ")
start = gets
ary = []
case type.to_i
when 0
     ary = start.scan(/([A-Z].+?)(?=([A-Z]|\Z))/).transpose[0]
when (1..2)
    ary = start.downcase.split("_")
end
case goal.to_i
when 0
    puts ary.inject(""){|sum,word| sum +=word.capitalize}
when (1..2)
    out = ary.inject(""){|sum,word| sum +=word+"_"}.chop!
    puts goal == 2?out.upcase! : out
end
