require("renderer")
require("map_generator")
-- This is practically the init function, everything is being loaded here,
-- as the name implies
function love.load()
	local screenWidth = love.graphics.getWidth()
	maps = {
		generate_map()
	}
	BLOCKSIZE = screenWidth / #maps[1][1]
	CAM_OFFSET_X = 0
	CAM_OFFSET_Y = 0

end

function love.focus(f)
	
end

function love.draw()
	render(maps)
end

--the main loop, dt stands for delta time in seconds
function love.update(dt)
	if love.keyboard.isDown("up") then
		plr.y = plr.y - plr.spd
	elseif love.keyboard.isDown("down") then
		plr.y = plr.y + plr.spd
	elseif love.keyboard.isDown("left") then
		plr.x = plr.x - plr.spd
	elseif love.keyboard.isDown("right") then
		plr.x = plr.x + plr.spd
	end
	
	if love.keyboard.isDown("escape") then
		love.event.quit()
	end
	
end

function love.quit(f)
end

