require "map_generator"

local write = io.write
local map = generate_map()

for i = 1, #map do
   for j = 1, #map[i] do
	  write(map[i][j])
   end
   write('\n')
end

