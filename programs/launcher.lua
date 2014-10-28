--FrostOS Launcher
--Require LMNets UI API!!
Banner = window.create(term.current(),1,1,xLen,1)
xLen,yLen = term.getSize()
Notify.run = false

local aDesktop = {}
local items = {}
local programs = fs.list("Programs")
local AppMenu = {}
local DesktopMenu = {}

local LinesWith = math.floor(xLen/5)
local LinesDeep = math.floor((yLen)/6)
local view = 1 --1 = Desktop, 2 = App Menu

local conv = {
	2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9
}
conv.a = 2^10
conv.b = 2^11
conv.c = 2^12
conv.d = 2^13
conv.e = 2^14
conv.f = 2^15
conv[0] = 1

Data = AppData.load()
if #Data < 1 then
	Data.desktop = {
	{ ["Name"] = "Example", 
	["ico"] = {{3,3,3,3},{4,4,4,4},{"f","f","f","e"},{1,2,3,4}},
	}
}
end

for _,v in pairs(Data.desktop) do
	table.insert(aDesktop,v)
end

function drawTime()
	while true do
		local time = textutils.formatTime(os.time(), false)
		if time:len() < 8 then
			time = "0"..time
		end
		Banner.setCursorPos(xLen-time:len(),1)
		Banner.write(time)
		sleep(1)
	end
end

function AppMenu.search(pIn)
	if not view == 2 then
		view = 2
		recreate()
	end
	--Handle more...
end

function drawBanner()
	Banner.clear()
	Banner.setCursorPos(1,1)
	Banner.setBackgroundColor(colors.black)
	Banner.setTextColor(colors.white)
	Banner.write("[Frost]")
end

function drawDesktop()
	for i,v in pairs(aDesktop) do
		local num = #items+1
		items[num] = createIcon(v)
		items[num]:draw()
	end
end

function AppMenu.__construct()
	AppMenu.items = {}
	for _,v in pairs(programs) do
		AppMenu.items[v] = {}
		AppMenu.items[v].name = v
		AppMenu.items[v].hasData = fs.exists(__APPS(v).."data")
		--Logo + Info
	end
end

function AppMenu.draw(pSite)
	if not AppMenu.items then
		AppMenu.__construct()
	end
	--Draw the launcher
end

function AppMenu.__destruct()
	AppMenu.items = nil
	AppMenu.seeObj = nil
end

local Tab = 1
local Row = 1

function getItemPos()
	if Row > LinesDeep then
		Tab = Tab+1
		Row = 1
	end
	local rtnY = 2+((Row-1)*6)
	local rtnX = 1+((Tab-1)*7)
	Row = Row+1
	return rtnX,rtnY
end

function createIcon(pElement)
	local rtn,rtn_m = {},{["__index"] = rtn_m}
	setmetatable(rtn,rtn_m)
	rtn.label = pElement.name
	rtn.ico = pElement.ico
	rtn.path = pElement.path
	rtn.beginX,rtn.beginY = getItemPos()
	
	if rtn.label:len() > 6 then
		rtn.label = rtn.label:sub(1,5)..">"
	end
	
	function rtn_m:isClicked(pX,pY)
		return pX >= self.startX and pX <= self.startX+7 and pY >= self.startY and pY <= self.startY+6
	end
	
	function rtn_m:draw()
		for i=1,4 do
			for j=1,4 do
				paintutils.drawPixel(beginX+(j-1),beginY+(i-1),conv[self['ico'][i][j]])
			end
		end
		term.setCursorPos(self.beginX-1,self.beginY+5)
		write(self.label)
	end
	
	return rtn
end

function mountDisk(pDisk)
	local t = {}
	t.name = pDisk
	t.path = "/pDisk"
	t.ico = {}
	
	items[#items+1] = createIcon(t)
	t = nil
	items[#items]:draw()
end

function recreate()
	if view == 1 then
		AppMenu.__destruct()
		drawDesktop()
	elseif view == 2 then
		DesktopMenu.__destruct()
		AppMenu.draw(1)
	end
end

drawBanner()
coroutine.create(drawTime)

while true do
	local ev = { os.pullEvent() }
	if ev[1] == "disk" then
		mountDisk(ev[2])
	elseif ev[1] == "mouse_click" then
		if ev[4] == 1 then
			--TopBanner
		else
			if ev[2] == 1 then
				--NClick
			else
				--RClick
			end
		end
	elseif ev[1] == "char" then
		AppMenu.search(ev[2])
	end
end