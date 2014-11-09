#!/usr/bin/ruby

def string_type(str)
    if !(str =~ /\D|\./) or (str =~ /^-/)
        return "int"
    elsif !(str =~ /\.|\-/) and (str =~ /\D/)
        return "string"
    elsif (str =~ /\D|\.|/) and !(str =~ /\-/)
        return "float"
    elsif (str =~ /..\-/) and !(str =~ /\.\D/)  
        return "date"
    else
        return "text"
    end
end


puts string_type("1234") #returns int
puts string_type("asdf, ghjk") # returns string
puts string_type("12.3") #returns float
puts string_type("12-23-2012") #returns date
puts string_type("-254") #returns int
