function parse_inputs()
	if love.keyboard.isDown("space") then
		player:jump()
	else
		player:apply_gravity()
	end
	
	if love.keyboard.isDown("escape") then
		love.event.quit()
	end
end
