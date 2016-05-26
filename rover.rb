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
				break if self.move_impossible?
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


	def move_impossible?
		case @direction
		when "N", "E"
		  (@x + 1 > AREA_LIMIT[0]) || (@y + 1 > AREA_LIMIT[1])
		when "W", "S"
			(@x - 1 < 0) || (@y - 1 < 0)
		end		
	end

	def move_forward
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

	def test_crash_protection_top
		rover = Rover.new(5,5,"N")
		rover.navigate("M")
		assert rover.x == 5
		assert rover.y == 5
		assert rover.direction = "N"
	end

	def test_crash_protection_right
		rover = Rover.new(5,1,"E")
		rover.navigate("M")
		assert rover.x == 5
		assert rover.y == 1
		assert rover.direction = "E"
	end

	def test_crash_protection_bottom
		rover = Rover.new(2,0,"S")
		rover.navigate("M")
		assert rover.x == 2
		assert rover.y == 0
		assert rover.direction = "S"
	end

	def test_crash_protection_left
		rover = Rover.new(0,3,"W")
		rover.navigate("M")
		assert rover.x == 0
		assert rover.y == 3
		assert rover.direction = "W"
	end

end


