fizz = require("fizzx.fizz")

local ball = {}

function ball:spawn()
	ball = fizz.addDynamic('circle', love.graphics.getHeight() - 10, 50, 8)
	ball.boune = 0.8
end


function ball:update(dt)
	--local vx, vy = fizz.getVelocity(game.ball)
	--vx = vx + 1000*dt
	--vy = vy + 1000*dt
	--fizz.setVelocity(ball, vx, vy)	
end


function ball:onCollide(b, nx, ny, pen)
	return true
end

return ball
