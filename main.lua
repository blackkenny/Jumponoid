require("globalconst")
require("renderer")
require("controls")
require("camera")
require("player")

game = require("game")

-- fizz module
fizz = require("fizzx.fizz")
fizz.setGravity(0, G)

-- This is practically the init function, everything is being loaded here,
-- as the name implies
function love.load()
   game:load_level()
   player = Player:create(game:getStartLocation())
end

function love.draw()
	if not game.isStarted then
		love.graphics.print("Press Space to start a new game", 10, 10)
	else
		set_camera(player.y)
		render()
	end
end

--the main loop, dt stands for delta time in seconds
function love.update(dt)
	if game.isStarted then
		game:update(dt)
	elseif love.keyboard.isDown("space") then
		game:start()
	end
	if love.keyboard.isDown("escape") then
		love.event.quit()
	end
end

function love.quit(f)
end

