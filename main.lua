-- tables for colours used by /r/place
rgb_red = {}
rgb_green = {}
rgb_blue = {}

rgb_red[0] = 0xff
rgb_green[0] = 0xff
rgb_blue[0] = 0xff

rgb_red[1] = 0xe4
rgb_green[1] = 0xe4
rgb_blue[1] = 0xe4

rgb_red[2] = 0x88
rgb_green[2] = 0x88
rgb_blue[2] = 0x88

rgb_red[3] = 0x22
rgb_green[3] = 0x22
rgb_blue[3] = 0x22

rgb_red[4] = 0xff
rgb_green[4] = 0xa7
rgb_blue[4] = 0xd1

rgb_red[5] = 0xe5
rgb_green[5] = 0x00
rgb_blue[5] = 0x00

rgb_red[6] = 0xe5
rgb_green[6] = 0x95
rgb_blue[6] = 0x00

rgb_red[7] = 0xa0
rgb_green[7] = 0x6a
rgb_blue[7] = 0x42

rgb_red[8] = 0xe5
rgb_green[8] = 0xd9
rgb_blue[8] = 0x00

rgb_red[9] = 0x94
rgb_green[9] = 0xe0
rgb_blue[9] = 0x44

rgb_red[10] = 0x02
rgb_green[10] = 0xbe
rgb_blue[10] = 0x01

rgb_red[11] = 0x00
rgb_green[11] = 0xe5
rgb_blue[11] = 0xf0

rgb_red[12] = 0x00
rgb_green[12] = 0x83
rgb_blue[12] = 0xc7

rgb_red[13] = 0x00
rgb_green[13] = 0x00
rgb_blue[13] = 0xea

rgb_red[14] = 0xe0
rgb_green[14] = 0x4a
rgb_blue[14] = 0xff

rgb_red[15] = 0x82
rgb_green[15] = 0x00
rgb_blue[15] = 0x80

function love.load()
	love.window.setMode(1000, 1000)
	love.window.setTitle("/r/place")

	-- store all pixels
	pixels = {}
	for i = 0, 999 do
		pixels[i] = {}
	end

	-- open csv file. this should not have the original header, and be
	-- sorted by increasing timestamp
	-- cat tile_placements.csv | sort --field-separator=',' --key=1 > sorted.csv
	fh = io.open("sorted.csv", "r")
end

function love.update(dt)
	-- read a lot of pixels into our pixel array
	-- this will be displayed in love.draw()
	for i = 0, 1000000 do
		-- read next line
		local line = fh:read()

		if line == nil then return end

		local ts,user,x,y,c = line:match("(.+),(.+),(.+),(.+),(.+)")

		x = tonumber(x)
		y = tonumber(y)
		c = tonumber(c)

		--print(x, y, c)

		if x > 999 or y > 999 then break end
		pixels[x][y] = c
	end
end

function love.draw()
	-- loop through pixels and draw them
	for y = 0, 999 do
		for x = 0, 999 do
			local c = pixels[x][y]
			if c then
				putPixel(x, y, c)
			end
		end
	end
end

function love.quit()
	fh:close()
end

-- takes x,y coordinates and /r/place colour value
function putPixel(x, y, c)
	love.graphics.setColor(rgb_red[c], rgb_green[c], rgb_blue[c])
	love.graphics.points(x, y)
end

