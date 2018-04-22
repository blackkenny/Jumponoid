require("globalconst")
require("renderer")
require("controls")
require("player")

game = require("game")
menu = require("menu")

function love.load()
   game:load_level(1)
   player = Player:create(game:getStartLocation())
end

function love.draw()
	if not game.isStarted then
		love.graphics.setBackgroundColor( 0, 0, 0 )
		menu.draw()
	else
		love.graphics.setBackgroundColor( 102/255, 149/255, 244/255 )
		game.camera:setViewport(player.y)
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

