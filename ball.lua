fizz = require("fizzx.fizz")

local ball = {}

function ball:spawn(y)
	ball = fizz.addDynamic('circle', 20, y * BLOCKSIZE, 8)
	ball.bounce = 1
	ball.gravity = 0
	ball.friction = 0
	ball.damping = 0
	fizz.setVelocity(ball, 1000, -1000)
end


function ball:update(dt)
	-- local vx, vy = fizz.getVelocity(ball)
	-- vx = vx + 1000*dt
	-- vy = vy -1000*dt
	-- fizz.setVelocity(ball, vx, vy)	
end


function ball:onCollide(b, nx, ny, pen)
	if b.isPlayer then 
		return false
	end

	return true
end

return ball
