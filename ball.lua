Ball = {}
Ball.__index = Ball

function Ball:create(fizz, y)
	local ball = fizz.addDynamic('circle', 20, y * BLOCKSIZE, 8)
	ball.bounce = 1
	ball.gravity = 0
	ball.friction = 0
	ball.damping = 0

	fizz.setVelocity(ball, 1000, -1000)

	setmetatable(ball, Ball)
	return ball
end

function Ball:onCollide(b, nx, ny, pen)
	if b.isPlayer then 
		return false
	end

	return true
end