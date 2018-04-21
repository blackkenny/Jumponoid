require("renderer")
require("controls")
require("camera")
require("player")
require("map_generator")
-- This is practically the init function, everything is being loaded here,
-- as the name implies
function love.load()
	local screenWidth = love.graphics.getWidth()
	maps = {
		generate_map()
	}
	BLOCKSIZE = screenWidth / #maps[1][1]
	player = Player:create(0, 0)
end

function love.focus(f)
	
end

function love.draw()
	set_camera(player.y)
	render(maps)
	render_player()
end

--the main loop, dt stands for delta time in seconds
function love.update(dt)
	parse_inputs()
end

function love.quit(f)
end

