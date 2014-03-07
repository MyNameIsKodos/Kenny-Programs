local term=require("term")


local function iterator()
	return coroutine.wrap( function()
		for line in string.gmatch( filmText, "([^\n]*)\n") do
			coroutine.yield(line)
		end
		return false
	end )
end

term.clear()
local it = iterator()
local bFinished = false

while not bFinished do
	local holdLine = it()
	if not holdLine then
		bFinished = true
		break
	end

	local cg = component.gpu
	local w,h = cg.getResolution()
	local startX = math.floor( (w - 65) / 2 )
	local startY = math.floor( (h - 14) / 2 )
	term.clear()

	for n=1,13 do
		local line = it()
		if line then
			term.setCursor(startX, startY + n)
			print( line )
		else
			bFinished = true
			break
		end
	end

	local hold = tonumber(holdLine) or 1
	local delay = (hold * 0.15) - 0.01
	os.sleep( delay )
end