function render(maps)
	for i = 1, #maps do
		render_map(maps[i])
	end
end

function render_map(map)
	for i = 1, #map do
		render_line(map[i], i)
	end
end

function render_line(line, lineNum)
	--1 = filled block
	--2 = outlined block
	
	local y = (lineNum - 1) * BLOCKSIZE
	
	for i = 1, #line do
		local blockType = line[i]
		local x = (i - 1) * BLOCKSIZE
		
		if blockType == 1 then
			love.graphics.rectangle('fill', x, y, BLOCKSIZE, BLOCKSIZE)
		elseif blockType == 2 then
			love.graphics.rectangle('line', x, y, BLOCKSIZE, BLOCKSIZE)
		end
	end
end


function render_player()
end

function render_blocks()
end

function render_paddle()
end

function render_ball()
end
