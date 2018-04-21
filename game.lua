require("map_loader")

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

		self.accum = self.accum - self.interval
		steps = steps + 1
		if steps >= self.maxsteps then
			break
		end
	end
end

function game.load_level()
	
	local map = load_map()
	
	h = 35
	w = #map/h
	
	local shapes =
	{
		-- solid block
		[2] = {'static', 'rect', 0, 0, BLOCKSIZE, BLOCKSIZE}
	}
	
	for x = 0, w - 1 do
		for y = 0, h - 1 do
			local i = map[y*w + x + 1]
			local wx, wy = x*BLOCKSIZE / 2, y*BLOCKSIZE / 2
			local s2 = shapes[i]
			if s2 then
				-- copy
				local t = { unpack(s2) }
				local s = table.remove(t, 1)
				-- transform
				t[2] = t[2] + wx
				t[3] = t[3] + wy
				if t[1] == "line" then
					t[4] = t[4] + wx
					t[5] = t[5] + wy
				end
				-- create
				local shape
				if s == 'dynamic' then
					shape = fizz.addDynamic(unpack(t))
					shape.friction = 0.1
				else
					shape = fizz.addStatic("rect", t[2] * 2, t[3] * 2, 20, 20)
				end
			end
		end
	end
end

function game:start()
	game.isStarted = true
end

function game:getStartLocation()
   return game.playerStartLocationX, game.playerStartLocationY
end


return game
