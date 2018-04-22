require("map_loader")

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

	ball = nil
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
	
	map_height = 35
	map_width = #map/map_height
	local ptr = 1
	
	for i = 1, map_height do
		for j = 1, map_width do
			local tiletype = map[ptr]
			local x = (j * BLOCKSIZE) - BLOCKSIZE / 2
			local y = (i * BLOCKSIZE) - BLOCKSIZE / 2
			if tiletype == 2 then
				fizz.addStatic("rect", x, y, BLOCKSIZE / 2, BLOCKSIZE / 2)
			end
			ptr = ptr + 1
		end
	end
end

function game:start()
	game.isStarted = true
end

function game:getStartLocation()
   return game.playerStartLocationX, game.playerStartLocationY
end

function game:spawnBall()
   game.ball = fizz.addDynamic('circle', 15, 15, 8)
   game.ball.bounce = 0.8
   function game.ball:onCollide(b, nx, ny, pen)
    -- return false if you want to ignore the collision
	  return true
   end

   function game.ball:update(dt)
	  local vx, vy = fizz.getVelocity(game.ball)
	  vx = vx + 1000*dt
	  vy = vy + 1000*dt
	  fizz.setVelocity(ball, vx, vy)
   end
end


return game
