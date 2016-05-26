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

  def current_location_as_string
    "#{@x} #{@y} #{@direction}"
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
		when NORTH
      (@x + MOVE_SPEED > AREA_LIMIT[0])
    when EAST
      (@x + MOVE_SPEED > AREA_LIMIT[0])
    when SOUTH
      (@y - MOVE_SPEED < 0) 
    when WEST
      (@x - MOVE_SPEED < 0)
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