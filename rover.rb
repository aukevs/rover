require 'minitest/autorun'
require 'minitest/benchmark'

class Rover	
	AREA_LIMIT = [5,5]
	attr_accessor :x, :y, :direction
	def initialize(x, y, direction)
		@x = x
		@y = y
		@direction = direction
	end

	def navigate(input)
		instructions = input.split("")
		for instruction in instructions
			case instruction
			when "L"
				self.rotate_left
			when "R"
				self.rotate_right
			when "M"
				self.move_forward
			end
		end
	end

	def rotate_left
		case @direction
		when "N"
			@direction = "W"
		when "W"
			@direction = "S"
		when "S"
			@direction = "E"
		when "E"
			@direction = "N"
		end
	end

	def rotate_right
		case @direction
		when "N"
			@direction = "E"
		when "E"
			@direction = "S"
		when "S"
			@direction = "W"
		when "W"
			@direction = "N"
		end
	end

	def move_forward
		return if (@x + 1 > AREA_LIMIT[0]) || (@y + 1 > AREA_LIMIT[1])
		case @direction
		when "N"
			@y += 1
		when "E"
			@x += 1
		when "W"
			@x -= 1
		when "S"
			@y -= 1
		end
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

	def test_moves_forward
		rover = Rover.new(0,0,"N")
		rover.move_forward
		assert rover.x == 0
		assert rover.y == 1
		assert rover.direction == "N"
	end

	def test_navigation_instruction_parser
		rover = Rover.new(1,2,"N")
		rover.navigate("LMLMLMLMM")
		assert rover.x = 1
		assert rover.y = 3
		assert rover.direction = "N"
		
		rover = Rover.new(3,3,"E")
		rover.navigate("MMRMMRMRRM")
		assert rover.x = 5
		assert rover.y = 1
		assert rover.direction = "E"
	end

	def test_plateau_edge_crash_protection
		rover = Rover.new(5,5,"N")
		rover.move_forward
		assert rover.x == 5
		assert rover.y == 5
		assert rover.direction = "N"
	end

end


