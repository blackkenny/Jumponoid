player = love.graphics.newImage( "images/player.png" )
block = love.graphics.newImage( "images/block.png" )

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
end

function drawObject(v, r, g, b)
	local lg = love.graphics
	if v.shape == 'rect' then
		local x, y, w, h = v.x, v.y, v.hw, v.hh
		drawBlock(x, y, w * 2, h * 2)
		-- lg.setColor(r, g, b, 255)
		-- lg.rectangle("line", x - w, y - h, w*2, h*2)
	elseif v.shape == 'circle' then
		local x, y, radius = v.x, v.y, v.r
		lg.setColor(r, g, b, 255)
		lg.circle("fill", x, y, radius, 32)
	elseif v.shape == 'line' then
		local x, y, x2, y2 = v.x, v.y, v.x2, v.y2
		lg.setColor(r, g, b, 255)
		lg.line(x, y, x2, y2)
	end
end

function drawBlock(x, y, width, height)
	local lg = love.graphics
	-- print("Width: " .. width)
	print("X: " .. x)
	local scaling = BLOCKSIZE / 32
	print("Scaling: " .. scaling)
	-- print("BLOCKSIZE: " .. BLOCKSIZE)
	-- print("How many times: " .. width / BLOCKSIZE)
	for i = 0, width / BLOCKSIZE -1 do
		-- print("x: " .. x .. "i: " .. i)
		lg.draw(block, (x - width / 2) + i * BLOCKSIZE, y - height/2, 0, scaling, scaling, 0, 0, 0, 0)
	end
end 
