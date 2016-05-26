require 'minitest/autorun'
require 'minitest/benchmark'

class Rover	

end

class TestSuite < MiniTest::Test
	def test_stores_start_position
		rover = Rover.new(1,2,"N")
		assert rover.x = 1
		assert rover.y = 2
		assert rover.direction = "N"
	end
end


