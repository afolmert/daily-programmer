#!/usr/bin/ruby

# If this integer is zero ('0'), then use CamcelCase. If it is one ('1'), use snake_case. If it is two ('2'), use capitalized snake_case.

module Notation
    CAMEL_CASE = 0
    SNAKE_CASE = 1
    CAPITALIZED_SNAKE_CASE = 2
end

def to_camel_case(text)
    words = text.split(' ')
    for i in 1...words.length
        words[i] = words[i][0].upcase + words[i][1..-1]
    end
    return words.join('')
end

def to_snake_case(text)
    words = text.split(' ')
    return words.join('_')
end

def to_capitalized_snake_case(text)
    words = text.split(' ')
    words = words.each_with_index.map { |w, i| i == 0 ? w : w[0].upcase + w[1..-1] }
    return words.join('_')
end


def codekata(input)

    notation, text = input.split("\n")

    case notation.to_i
    when Notation::CAMEL_CASE 
        puts to_camel_case(text)
    when Notation::SNAKE_CASE 
        puts to_snake_case(text)
    when Notation::CAPITALIZED_SNAKE_CASE 
        puts to_capitalized_snake_case(text)
    end

end



def run_tests

    codekata <<HEREDOC
1
user id
HEREDOC


    codekata <<HEREDOC
0
hello world
HEREDOC

    codekata <<HEREDOC
2
map controller delegate manager
HEREDOC


end




run_tests
