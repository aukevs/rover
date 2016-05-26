require './rover'

class RoverController
	def request_input
		puts "Please enter the size of the area seperated by a space (5 5)"
		@area_size = STDIN.gets.chomp
		puts "Please enter the start position of the first rover (1 2 N)"
		@rover1_start_position = STDIN.gets.chomp
		puts "Please enter instructions for rover 1 (LMLMLMLMM)"
		@rover1_instructions = STDIN.gets.chomp
		puts "Please enter the start position of the second rover (3 3 E)"
		@rover2_start_position = STDIN.gets.chomp
		puts "Please enter the start position of the second rover (MMRMMRMRRM)"
		@rover2_instructions = STDIN.gets.chomp 
		puts "Press enter to start navigating the routers"
		any_key = STDIN.gets.chomp
		
		puts "Navigating Rovers"

		rover1_start = @rover1_start_position.split(" ")
		rover1 = Rover.new(rover1_start[0].to_i,rover1_start[1].to_i,rover1_start[2])
		rover1.navigate(@rover1_instructions)

		puts "Rover 1 ended in location:"
		puts rover1.current_location_as_string

		rover2_start = @rover2_start_position.split(" ")
		rover2 = Rover.new(rover2_start[0].to_i,rover2_start[1].to_i,rover2_start[2])
		rover2.navigate(@rover2_instructions)

		puts "Rover 2 ended in location:"
		puts rover2.current_location_as_string

	end
end

rover_controller = RoverController.new
rover_controller.request_input 