playerImage = love.graphics.newImage( "images/player.png" )
blockImage = love.graphics.newImage( "images/block.png" )
ballImage = love.graphics.newImage( "images/ball.png" )

function render()
	local lg = love.graphics
	for i, v in ipairs(fizz.statics) do
		-- table.foreach(v, print)
		drawObject(v, .5, .5, .5)
	end
	for i, v in ipairs(fizz.dynamics) do
		drawObject(v, 1, .5, .5)
	end
	for i, v in ipairs(fizz.kinematics) do
		drawObject(v, 1, .5, 1)
	end
	local mem = collectgarbage('count')
	mem = math.ceil(mem)
	local jt = "instant"
	if JUMPTERM > 0 then
		jt = "gradual"
	end
	drawScore()
end

function drawScore()
	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.setFont(game.fonts.scoreFont)
	local y = player.y - game.camera.topDistance
	y = math.min(y, math.abs(game.camera.min))
	love.graphics.print(game.score, BLOCKSIZE / 20, y)
end

function drawObject(v, r, g, b)
	local lg = love.graphics
	if v.shape == 'rect' then
		local x, y, w, h = v.x, v.y, v.hw, v.hh
		if v.isPlayer then 
			lg.setColor(1, 1, 1, 255)
			drawImage(playerImage, x, y - BLOCKSIZE / 5, w * 2, h * 2)
		else
			lg.setColor(1, 0, 0, 255)
			drawImage(blockImage, x, y, w * 2, h * 2)
		end
		-- lg.setColor(r, g, b, 255)
		-- lg.rectangle("line", x - w, y - h, w*2, h*2)
	elseif v.shape == 'circle' then
		local x, y, radius = v.x, v.y, v.r
		lg.setColor(1, 60/255, 0, 1)
		lg.circle("fill", x, y, radius, 32)
	elseif v.shape == 'line' then
		local x, y, x2, y2 = v.x, v.y, v.x2, v.y2
		lg.setColor(r, g, b, 1)
		lg.line(x, y, x2, y2)
	end
end

function drawImage(image, x, y, width, height)
	local lg = love.graphics
	local scaling = BLOCKSIZE / 64
	for i = 0, width / BLOCKSIZE -1 do
		lg.draw(image, (x - width / 2) + i * BLOCKSIZE, y - height/2, 0, scaling, scaling, 0, 0, 0, 0)
	end
end 
