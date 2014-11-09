#!/usr/bin/env ruby
#
# Solution to Challenge #113 [Easy] String-type checking
#

require 'date'


def digit?(c)
    return c =~ /[[:digit:]]/ ? true : false
end

def int?(input)
    result = true
    input.chars.each_with_index do |c, i|
        if i == 0 && (c == '+' || c == '-')
            next
        elsif digit?(c)
            next
        else
            result = false
            break
        end

    end

    return result
end


def float?(input)
    result = true
    did_dot = false
    input.chars.each_with_index do |c, i|
        if i == 0 && (c == '+' || c == '-')
            next
        elsif digit?(c)
            next
        elsif c == '.' && !did_dot
            did_dot = true
            next
        else
            result = false
            break
        end

    end

    return result && did_dot
end


# is date in format DD-MM-YYYY
def date?(input)
    if input =~ /(\d\d)-(\d\d)-(\d\d\d\d)/
        begin
            mday = $1
            month = $2
            year = $3
            d = DateTime.new(year.to_i, month.to_i, mday.to_i)
            return d.strftime("%d-%m-%Y") == input
        rescue
            return false
        end

    else

        return false
    end
end


def check_type(input)
    if date?(input)
        puts "#{input}: date"
    elsif float?(input)
        puts "#{input}: float"
    elsif int?(input)
        puts "#{input}: int"
    else
        puts "#{input}: text"
    end
end


 
 

def main
    check_type "12-12-2013"
    check_type "13-13-1001"
    check_type "01-01-1001"
    check_type "+1234"
    check_type "+1234.12"
    check_type "+1234.12.12"
    check_type "-012"
    check_type "-012+"
    check_type "-1234.0"
    check_type "lazy fox jumped!"
end



main

