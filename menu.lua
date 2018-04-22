Menu = {}

function Menu:draw()
	font = love.graphics.newFont("pac.ttf", 40 )
	love.graphics.setFont(font)
	love.graphics.print("Press Space to start a new game", 120, love.graphics.getHeight() / 2 - 50)
end

return Menu
