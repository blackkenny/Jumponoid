Menu = {
	fonts = {
		titleFont = love.graphics.newFont( "fonts/pac.ttf", 120 ),
		textFont = love.graphics.newFont(14),
		subHeaderFont = love.graphics.newFont(18)
	}
}

function Menu:draw()
	love.graphics.setFont(self.fonts.titleFont)
	love.graphics.print("JUMPONOID", love.graphics.getWidth() / 2 - 490, 100)
	
	love.graphics.setFont(self.fonts.subHeaderFont)
	love.graphics.print("Press space to start a new game", love.graphics.getWidth() / 2 - 150, love.graphics.getHeight() / 2)
	
	love.graphics.setFont(self.fonts.textFont)
	love.graphics.print("v0.0.0", love.graphics.getWidth() - 55, love.graphics.getHeight() - 25)
	love.graphics.print("Bananicorn & Blackkenny ©2018", 15, love.graphics.getHeight() - 25)
end

return Menu
