Player = {}
Player.__index = Player

local isJumpButtonReady = true

function Player:create (x, y)
    local player = fizz.addDynamic('rect', x, y, BLOCKSIZE / 2, BLOCKSIZE / 2)
	player.friction = 0.15
	player.isPlayer = true
	-- player flags
	player.grounded = false
	player.jumping = false
	player.doubleJumping = false
	player.moving = false
	player.isMidAir = false
	
	setmetatable(player, Player)
	return player
end

function Player:onCollide(b, nx, ny, pen)
	--wall jumps in here?
	return true
end

function love.keyreleased(key)
	if key == "space" then
		isJumpButtonReady = true
	end
end

-- process user input
function Player:checkInput(dt)
	-- get user input
	local left = love.keyboard.isDown('left')
	local right = love.keyboard.isDown('right')
	local jump = love.keyboard.isDown('space')
	

	-- get player velocity
	local vx, vy = fizz.getVelocity(self)
	-- get the player displacement
	local sx, sy = fizz.getDisplacement(self)

	-- something is pushing the player up?
	self.grounded = false
	if sy < 0 then
		self.grounded = true
		self.jumping = false
		self.doubleJumping = false
		self.isMidAir = false
	end

	-- running (horizontal movement)
	self.moving = left or right
	if self.moving then
		-- movement vector
		local move = 3000
		if left then
			move = -3000
		end
		-- slower movement while in the air
		if not self.grounded then
			move = move/8
		end
		-- add to player velocity
		vx = vx + move*dt
	end

	-- jumping (vertical movement)
	if jump and not self.doubleJumping and self.isMidAir and isJumpButtonReady then
		self.doubleJumping = true
		vy = -INITJUMPV
		isJumpButtonReady = false
	elseif jump and not self.jumping and self.grounded and isJumpButtonReady then
		-- initiating a jump
		self.jumping = true
		self.isMidAir = true
		vy = -INITJUMPV
		isJumpButtonReady = false
	elseif not jump and self.jumping and not self.grounded then
		-- terminating a jump
		if self.yv < 0 and self.yv < -JUMPTERM then
			vy = -JUMPTERM
		end
		self.jumping = false
		self.doubleJumping = false
	end

	-- update player velocity
	fizz.setVelocity(self, vx, vy)
end
