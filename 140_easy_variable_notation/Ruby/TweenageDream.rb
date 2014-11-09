#!/usr/bin/ruby


class String
  def camelCase
    self.gsub(/ [a-z]/){|s| s[-1].upcase}
  end

  def snakeCase
    self.tr(' ','_').downcase
  end

  def capSnakeCase
    self.tr(' ','_').upcase
  end

  def normal
    self.tr('_',' ').gsub(/[A-Z]/){|s| " #{s.downcase}"}
  end
end

def convert(to, words)
  case to.to_i
    when 0 then words.camelCase
    when 1 then words.snakeCase
    when 2 then words.capSnakeCase
    else raise "Invalid conversion"
  end
end

if __FILE__ == $0
  from, to = $<.readline.split(" ")
  if to.nil?
    words = $<.readline
    puts convert(from,words)
  else
    raise "Invalid conversion" unless [0,1,2].include?(from.to_i)
    puts convert(to,$<.readline.normal)
  end
end
