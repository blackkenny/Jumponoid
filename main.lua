require("globalconst")
require("renderer")
require("controls")
require("camera")
require("player")
require("map_loader")

-- let's calculate some constants!
-- jump heights
local maxjumpH = 16*4
local minjumpH = 16*1
-- jump time to apex
local maxjumpT = 0.4
-- gravity
g = (2*maxjumpH)/(maxjumpT^2)
-- initial jump velocity
initjumpV = math.sqrt(2*g*maxjumpH)
-- jump termination velocity
termjumpV = math.sqrt(initjumpV^2 + 2*-g*(maxjumpH - minjumpH))
-- jump termination time
termjumpT = maxjumpT - (2*(maxjumpH - minjumpH)/(initjumpV + termjumpV))
-- default jump termination
jumpTerm = termjumpV

game = require("game")

-- fizz module
fizz = require("fizzx.fizz")
fizz.setGravity(0, g)

-- This is practically the init function, everything is being loaded here,
-- as the name implies
function love.load()
	game.load_level()
	player = Player:create(0,0)
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

