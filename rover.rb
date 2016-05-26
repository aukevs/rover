require 'minitest/autorun'
require 'minitest/benchmark'

class Rover	
	AREA_LIMIT = [5,5]
	MOVE_SPEED = 1
	LANG = {left: "L", right: "R", move: "M"}
	NORTH = "N"
	WEST = "W"
	SOUTH = "S"
	EAST = "E"

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
			when LANG[:left]
				self.rotate_left
			when LANG[:right]
				self.rotate_right
			when LANG[:move]
				break if self.move_impossible?
				self.move_forward
			end
		end
	end
	
	def current_location
		{x: @x, y: @y, facing: @direction}
	end

	protected
	
	def rotate_left
		case @direction
		when NORTH
			@direction = WEST
		when WEST
			@direction = SOUTH
		when SOUTH
			@direction = EAST
		when EAST
			@direction = NORTH
		end
	end

	def rotate_right
		case @direction
		when NORTH
			@direction = EAST
		when EAST
			@direction = SOUTH
		when SOUTH
			@direction = WEST
		when WEST
			@direction = NORTH
		end
	end


	def move_impossible?
		case @direction
		when NORTH, EAST
			# Move would hit a x or y coordinate that is larger then the AREA_LIMIT ex: 6,6
		  (@x + MOVE_SPEED > AREA_LIMIT[0]) || (@y + MOVE_SPEED > AREA_LIMIT[1])
		when WEST, SOUTH
			# Move would hit a x or y coordinate that is smaller then the AREA_LIMIT ex: -1,0
			(@x - MOVE_SPEED < 0) || (@y - MOVE_SPEED < 0)
		end		
	end

	def move_forward
		case @direction
		when NORTH
			@y += MOVE_SPEED
		when EAST
			@x += MOVE_SPEED
		when WEST
			@x -= MOVE_SPEED
		when SOUTH
			@y -= MOVE_SPEED
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
		rover.send(:rotate_left)
		assert rover.direction == "W"
	end

	def test_rotates_right
		rover = Rover.new(0,0,"N")
		rover.send(:rotate_right)
		assert rover.direction == "E"
	end

	def test_moves_forward
		rover = Rover.new(0,0,"N")
		rover.send(:move_forward)
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

	def test_retrieve_current_location
		rover = Rover.new(0,3,"W")
		assert rover.current_location == {x: 0, y: 3, facing: "W"}
	end

end


