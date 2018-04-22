local screenWidth = love.graphics.getWidth()
BLOCKSIZE = screenWidth / 25
-- jump heights
local maxjumpH = BLOCKSIZE*5
local minjumpH = BLOCKSIZE*1
-- jump time to apex
local maxjumpT = 0.4
-- gravity
G = (2*maxjumpH)/(maxjumpT^2)
INITJUMPV = math.sqrt(2*G*maxjumpH)

-- jump termination velocity
local termjumpV = math.sqrt(INITJUMPV^2 + 2*-G*(maxjumpH - minjumpH))
-- jump termination time
local termjumpT = maxjumpT - (2*(maxjumpH - minjumpH)/(INITJUMPV + termjumpV))
-- default jump termination
JUMPTERM = termjumpV
