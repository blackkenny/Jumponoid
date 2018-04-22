local camera = {
	max = 0,
	min = 0,
	topDistance = BLOCKSIZE * 7
}

function camera:setViewport(y)
	local camY = self.topDistance - y
	camY = math.max(camY,self.min)
	camY = math.min(camY,self.max)
	love.graphics.translate(0, camY)
end

return camera
