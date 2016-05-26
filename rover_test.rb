require 'minitest/autorun'
require './rover'
class TestSuite < MiniTest::Test
	def test_stores_start_position
		rover = Rover.new(1,2,"N")
		assert rover.x == 1
		assert rover.y == 2
		assert rover.direction == "N"
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
		assert rover.x == 1
		assert rover.y == 3
		assert rover.direction == "N"
		
		rover = Rover.new(3,3,"E")
		rover.navigate("MMRMMRMRRM")
		assert rover.x == 5
		assert rover.y == 1
		assert rover.direction == "E"
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