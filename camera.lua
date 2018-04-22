local camera = {
	max = 0,
	min = 0,
	topDistance = BLOCKSIZE * 7
}

function camera:setViewport(y)
	local camY = self.topDistance - y
	print('max: ' .. self.max)
	print('min: ' .. self.min)
	print('y: ' .. camY)
	camY = math.max(camY,self.min)
	camY = math.min(camY,self.max)
	print('y: ' .. camY)
	love.graphics.translate(0, camY)
end

return camera
