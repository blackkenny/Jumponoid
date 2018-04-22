require("globalconst")
require("renderer")
require("controls")
require("camera")
require("player")

game = require("game")
menu = require("menu")

function love.load()
   game:load_level()
   player = Player:create(game:getStartLocation())
end

function love.draw()
	if not game.isStarted then
		menu.draw()
	else
		set_camera(player.y)
		render()
	end
end

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

