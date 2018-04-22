require("map_loader")
require("ball")

fizz = require("fizzx.fizz")
fizz.setGravity(0, G)

destructiblesToRemove = {}

local game = {
	isStarted = false,
-- update interval in seconds
	interval = 1/60,
	-- maximum frame skip
	maxsteps = 5,
	-- accumulator
	accum = 0,
	playerStartLocationX = 0,
	playerStartLocationY = 0,
	mapHeight = 0,
	mapWidth = 0,
	camera = require("camera")
}
game.__index = game

function game:initCamera()
	self.camera.min = -self.mapHeight + love.graphics.getHeight()
end

function game:update(dt)
	local steps = 0
	-- update the simulation
	self.accum = self.accum + dt
	while self.accum >= self.interval do
		-- handle player input
		player:checkInput(self.interval)

		-- update the simulation
		fizz.update(self.interval)
		game:removeDestructibles()
		self.accum = self.accum - self.interval
		steps = steps + 1
		if steps >= self.maxsteps then
			break
		end
	end

end

function game:load_levels()
	game:load_level(1, 0)
	game:load_level(2, 35)
	game:load_level(3, 70)
end

function game:load_level(levelnum, offset)
	print(levelnum)
	local map = require("maps.map" .. levelnum)
	
	local ptr = 1
	local prevBlock = 1
	local currentWidth = 0
	
	self.mapWidth = map.width * BLOCKSIZE
	self.mapHeight = self.mapHeight + map.height * BLOCKSIZE
	print(self.mapHeight)
	
	for i = 1, map.height do
		for j = 1, map.width do
			local curr_map = map.layers[1].data
			local tiletype = curr_map[ptr]
			local x = (j * BLOCKSIZE)
			local y = (i * BLOCKSIZE) + (offset * BLOCKSIZE)
			
			if tiletype == 3 then
				currentWidth = currentWidth + 1
				if curr_map[ptr + 1] ~= tiletype or j == map.width then
					fizz.addStatic("line", x, y + BLOCKSIZE / 2, x - (currentWidth * BLOCKSIZE), y + BLOCKSIZE / 2)
					currentWidth = 0
				end
			elseif tiletype == 2 then
				currentWidth = currentWidth + 1
				if curr_map[ptr + 1] ~= tiletype or j == map.width then
					local rect = fizz.addStatic("rect", x - (currentWidth * BLOCKSIZE / 2), y, (BLOCKSIZE / 2) * currentWidth, BLOCKSIZE / 2)
					rect.isDestructible = true
					currentWidth = 0
				end
			elseif tiletype == 4 then
				game.playerStartLocationX = x
				game.playerStartLocationY = y
			end
			ptr = ptr + 1
			prevBlock = tiletype
		end
	end
	--add left/right boundaries
	fizz.addStatic("line", map.width * BLOCKSIZE, 0, map.width * BLOCKSIZE, self.mapHeight)
	fizz.addStatic("line", 0, self.mapHeight, 0, 0)

	-- local goalLine = fizz.addStatic("line", 0, -5 + offset * BLOCKSIZE , map.width * BLOCKSIZE, -5 + offset * BLOCKSIZE)
	-- goalLine.isGoal = true
	fizz.addStatic("line", map.width * BLOCKSIZE, (map.height + offset) * BLOCKSIZE, 0, (map.height + offset) * BLOCKSIZE)
	local goal = fizz.addStatic("rect", 0, 10 + offset * BLOCKSIZE, map.width * BLOCKSIZE, BLOCKSIZE / 5)
	goal.isGoal = true
	self:initCamera()
end

function game:onDestructibleCollision(b)
	destructiblesToRemove[#destructiblesToRemove + 1] = b
end

function game:start()
	self.isStarted = true
	ball = Ball:create(fizz, game.playerStartLocationY, self.onDestructibleCollision)
end

function game:getStartLocation()
   return game.playerStartLocationX, game.playerStartLocationY
end

function game:removeDestructibles()
	for i = #destructiblesToRemove, 1, -1 do
		if destructiblesToRemove[i] then
			fizz.removeShape(destructiblesToRemove[i])
			destructiblesToRemove[i] = nil
		end
	end
end

return game
