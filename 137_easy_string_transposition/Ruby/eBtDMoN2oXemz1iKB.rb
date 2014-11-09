#!/usr/bin/ruby

a=$<.read.split[1..-1];$;='';puts a.map{|m|m+' '*(a.map(&:size).max-m.size)}.map(&:split).transpose.map(&:join)
