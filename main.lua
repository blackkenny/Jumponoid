-- This is practically the init function, everything is being loaded here,
-- as the name implies
function love.load ()
	Message = "Holy shit, LÖVE is AWESOME!"
	local secret = 'This is a local string' -- local variable, apostrophes on the string.
	plr = {
		x = 200,
		y = 300,
		w = 10,
		h = 10,
		spd = 8
	}
	
	static_box = {
		x = 200,
		y = 350,
		w = 20,
		h = 50
	}

end

function collision (f)
	
end

function love.focus (f)
	if not f then
		print("I should pause here")
	else
		--I probably shouldn't do much here, since automatic unpausing is shitty
	end
end

function love.draw ()
	love.graphics.print(Message, 10, 10)
	love.graphics.rectangle('fill', plr.x, plr.y, plr.w, plr.h)
	love.graphics.rectangle('line', static_box.x, static_box.y, static_box.w, static_box.h)
end

--the main loop, dt stands for delta time in seconds
function love.update (dt)
	if love.keyboard.isDown("up") then
		plr.y = plr.y - plr.spd
	elseif love.keyboard.isDown("down") then
		plr.y = plr.y + plr.spd
	elseif love.keyboard.isDown("left") then
		plr.x = plr.x - plr.spd
	elseif love.keyboard.isDown("right") then
		plr.x = plr.x + plr.spd
	end
	
	if love.keyboard.isDown("escape") then
		love.event.quit()
	end
	
end

function love.quit (f)
	print("Maybe save inside that function")
end

