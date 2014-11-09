#!/usr/bin/ruby


class Board
	def initialize(width, height)
		@width = width
		@height = height
		@data = Array.new(width * height)
		for i in 1..width 
			@data[i] = 0
		end
	end
	
	def print
		puts "My width is #@width and height is #@height"
		puts "#@data"

	end
end


puts "Hello world!"

b = Board.new(10, 20)

b.print
(1...3).each do |x|
	puts x
end
	

