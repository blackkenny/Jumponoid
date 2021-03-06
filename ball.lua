Ball = {}
Ball.__index = Ball

source = love.audio.newSource( "sounds/explosion.wav", "static" )

function Ball:create(fizz, y, onDestructibleCollision)
	local ball = fizz.addDynamic('circle', 20, y, 8)
	ball.bounce = 1
	ball.gravity = 0
	ball.friction = 0
	ball.damping = 0
	ball.onDestructibleCollision = onDestructibleCollision

	fizz.setVelocity(ball, 500, -500)

	setmetatable(ball, Ball)
	return ball
end

function Ball:onCollide(b, nx, ny, pen)
	if b.isPlayer then 
		return false
	end

	if b.isDestructible then
		self:onDestructibleCollision(b)
		love.audio.play( source )
	end

	if b.isGoal then
		return true
	end

	return true
end