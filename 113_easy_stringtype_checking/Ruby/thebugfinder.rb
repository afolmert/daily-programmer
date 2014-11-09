#!/usr/bin/ruby


def validate(s)
    if s.scan(/^[+-]?\d+(\.\d*)?$/){ |dec| 
        return :int if dec[0].nil?
        return :float
    }
    end

    return :date if s.match(/^(0?[1-9]|1[0-9]|2[0-9]|3[01])-(0?[1-9]|1[0-2])-(\d\d){1,2}$/)
    return :text
end

def validate2(s)
    begin
        Float(s) != nil
    rescue
        require 'date'
        Date.parse(s) rescue return :text
        return :date
    else
        Integer(s) != nil rescue return :float
        return :int
    end
end



require "test/unit"

class TestTypeCheck < Test::Unit::TestCase
    def test_simple
        cases = {
            :int => [
                "34",
                "+33",
                "-33",
                "0", #zero
                "+0", #zero
                "-0", #zero
                "-999999999999444444444444444434567890", #big num
                #"  9  ", #trailing spaces
                ],
            :float => [
                "1.22",
                "+1.22",
                "-1.22",
                "0.00000",
                "+0.00",
                "-0.00",
                "1.",
                "-999999999999444444444444444434567890.99", #big num
                ],
            :date => [
                "20-11-2015",
                "31-12-99",
                "01-01-00",
                "01-01-0000",
                "01-09-99",
                ],

            :text => [
                "X",
                "", #empty string
                "          ", #spaces string
                "  9  ", #trailing spaces
                "1.2.3",
                "-9345.99.",
                "-9345.99.0",
                "-.0",
                "-.0",
                "3.xx",

                #invalid dates
                "0-0-55",
                "00-00-55",
                "-12-2012",
                "30--2012",
                "20-11-015",
                "020-011-015",
                "20-11-5",

                #out of range dates
                "20-41-55",
                "20-13-2012",
                "32-11-2015",
            ],
        }
        cases.each do |type, e|
            e.each { |input| assert_equal(validate(input), type, "Input: #{input}") }
        end
    end
end
