#!/usr/bin/ruby -w

require 'test/unit'

class String
  CODE_NORMAL         = 0
  CODE_CAMEL_CASE     = 1
  CODE_SNAKE_CASE     = 2
  CODE_CAP_SNAKE_CASE = 3

  def convert(mode)
    # convert to normal mode first
    result = self.gsub(/_/, ' ').gsub(/([^A-Z ])([A-Z])/, '\1 \2').downcase

    case mode
      when CODE_CAMEL_CASE     then result.gsub(/\s+(.+)/) { $1.capitalize }
      when CODE_SNAKE_CASE     then result.gsub(/\b(\s+)\b/, '_')
      when CODE_CAP_SNAKE_CASE then result.gsub(/\b(\s+)\b/, '_').upcase
      else result
    end
  end
end

class TestCodingConventions < Test::Unit::TestCase
  def setup
    @normal         = 'hello world'
    @camel_case     = 'helloWorld'
    @snake_case     = 'hello_world'
    @cap_snake_case = 'HELLO_WORLD'
  end

  def test_convert_from_normal
    assert_equal(@normal,         @normal.convert(String::CODE_NORMAL))
    assert_equal(@camel_case,     @normal.convert(String::CODE_CAMEL_CASE))
    assert_equal(@snake_case,     @normal.convert(String::CODE_SNAKE_CASE))
    assert_equal(@cap_snake_case, @normal.convert(String::CODE_CAP_SNAKE_CASE))
  end

  def test_convert_from_camel_case
    assert_equal(@normal,         @camel_case.convert(String::CODE_NORMAL))
    assert_equal(@camel_case,     @camel_case.convert(String::CODE_CAMEL_CASE))
    assert_equal(@snake_case,     @camel_case.convert(String::CODE_SNAKE_CASE))
    assert_equal(@cap_snake_case, @camel_case.convert(String::CODE_CAP_SNAKE_CASE))
  end

  def test_convert_from_snake_case
    assert_equal(@normal,         @snake_case.convert(String::CODE_NORMAL))
    assert_equal(@camel_case,     @snake_case.convert(String::CODE_CAMEL_CASE))
    assert_equal(@snake_case,     @snake_case.convert(String::CODE_SNAKE_CASE))
    assert_equal(@cap_snake_case, @snake_case.convert(String::CODE_CAP_SNAKE_CASE))
  end

  def test_convert_from_cap_snake_case
    assert_equal(@normal,         @cap_snake_case.convert(String::CODE_NORMAL))
    assert_equal(@camel_case,     @cap_snake_case.convert(String::CODE_CAMEL_CASE))
    assert_equal(@snake_case,     @cap_snake_case.convert(String::CODE_SNAKE_CASE))
    assert_equal(@cap_snake_case, @cap_snake_case.convert(String::CODE_CAP_SNAKE_CASE))
  end
end
