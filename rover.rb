require 'minitest/autorun'
require 'minitest/benchmark'

class Rover	
	attr_accessor :x, :y, :direction
	def initialize(x, y, direction)
		@x = x
		@y = y
		@direction = direction
	end
end

class TestSuite < MiniTest::Test
	def test_stores_start_position
		rover = Rover.new(1,2,"N")
		assert rover.x = 1
		assert rover.y = 2
		assert rover.direction = "N"
	end

	def test_rotates_left
		rover = Rover.new(0,0,"N")
		rover.rotate_left
		assert rover.direction == "W"
	end

	def test_rotates_right
		rover = Rover.new(0,0,"N")
		rover.rotate_right
		assert rover.direction == "E"
	end

end


