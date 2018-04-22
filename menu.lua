Menu = {}

function Menu:draw()
	titleFont = love.graphics.newFont( "fonts/pac.ttf", 120 )
	love.graphics.setFont(titleFont)
	love.graphics.print("JUMPONOID", love.graphics.getWidth() / 2 - 490, 100)
	
	subHeaderFont = love.graphics.newFont(18)
	love.graphics.setFont(subHeaderFont)
	love.graphics.print("Press space to start a new game", love.graphics.getWidth() / 2 - 150, love.graphics.getHeight() / 2)
	
	textFont = love.graphics.newFont(14)
	love.graphics.setFont(textFont)
	love.graphics.print("v0.0.0", love.graphics.getWidth() - 55, love.graphics.getHeight() - 25)
	love.graphics.print("Bananicorn & Blackkenny ©2018", 15, love.graphics.getHeight() - 25)
end

return Menu
