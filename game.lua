require("map_loader")

ball = require("ball")

fizz = require("fizzx.fizz")
fizz.setGravity(0, G)

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
}
game.__index = game

function game:update(dt)
	local steps = 0
	-- update the simulation
	self.accum = self.accum + dt
	while self.accum >= self.interval do
		-- handle player input
		player:checkInput(self.interval)

		-- update the simulation
		fizz.update(self.interval)
		-- self.ball.update(dt)

		self.accum = self.accum - self.interval
		steps = steps + 1
		if steps >= self.maxsteps then
			break
		end
	end

end

function game:load_level(levelnum)
	
	local map = require("maps.map" .. levelnum)
	
	local ptr = 1
	local prevBlock = 1
	local currentWidth = 0
	local maxWidth = 200
	
	for i = 1, map.height do
		for j = 1, map.width do
			local curr_map = map.layers[1].data
			local tiletype = curr_map[ptr]
			local x = (j * BLOCKSIZE)
			local y = (i * BLOCKSIZE)
			
			if tiletype == 3 then
				currentWidth = currentWidth + 1
				if curr_map[ptr + 1] ~= tiletype or j == map.width or currentWidth >= maxWidth then
					fizz.addStatic("line", x, y + BLOCKSIZE / 2, x - (currentWidth * BLOCKSIZE), y + BLOCKSIZE / 2)
					currentWidth = 0
				end
			elseif tiletype == 2 then
				currentWidth = currentWidth + 1
				if curr_map[ptr + 1] ~= tiletype or j == map.width or currentWidth >= maxWidth then
					fizz.addStatic("rect", x - (currentWidth * BLOCKSIZE / 2), y, (BLOCKSIZE / 2) * currentWidth, BLOCKSIZE / 2)
					currentWidth = 0
				end
			elseif tiletype == 4 then
				game.playerStartLocationX = j
				game.playerStartLocationY = i
			end
			ptr = ptr + 1
			prevBlock = tiletype
		end
	end
	--add left/right boundaries
	fizz.addStatic("line", map.width * BLOCKSIZE, 0, map.width * BLOCKSIZE, map.height * BLOCKSIZE)
	fizz.addStatic("line", 0, map.height * BLOCKSIZE, 0, 0)
end

function game:start()
	game.isStarted = true
	ball.spawn()
end

function game:getStartLocation()
   return game.playerStartLocationX, game.playerStartLocationY
end

return game
