--[[
timia2109s Notify API FrostOS Edition
]]
_G["notifyPush"] = {}
local evNtf = {}
local show = true
local events = false
local xLen,yLen = term.getSize()
local notifyWindow = window.create(1,1,xLen,3,false)
_G.Notify = {}
Notify.run = true
Notify.banner = true

function Notify.clearNtf()
	for i=1,3 do
		term.setCursorPos(1,i)
		term.clearLine()
	end
	term.setTextColor(colors.white)
	term.setBackgroundColor(colors.black)
end

function Notify.showNtf(pApp,pID,pM1,pM2)
	for i=1,3 do
		term.setCursorPos(1,i)
		term.clearLine()
		for j=1,xLen do
			paintutils.drawPixel(j,i,colors.white)
		end
	end
	term.setCursorPos(1,1)
	term.setTextColor(colors.black)
	print("[x] [N] Notify <"..pApp..">")
	print(pM1)
	print(pM2)
	local runN = true
	os.startTimer(3)
	while runN do
		local ev = {os.pullEvent()}
		if ev[1] == 'char' then
			if ev[2] == 'n' then
				execNotify(pID)
			elseif ev[2] == 'x' then
				clearNtf()
				runN = false
			end
		elseif ev[1] == 'mouse_click' then
			if ev[4] >= 1 and ev[4] <= 3 then
				if ev[3] >= 1 and ev[3] <= 3 then
					clearNtf()
					runN = false
				else
					execNotify(pID)
				end
			end
		elseif ev[1] == 'timer' then
			clearNtf()
			runN = false
		end
	end
end

function Notify.pushEvent(pApp,pM1,pM2,pID)
	os.queueEvent("notify_now",pID,pApp,pM1,pM2)
	if show then
		showNtf(pApp,pID,pM1,pM2)
	end
end

function Notify.remove(pID)
	if notifyPush[pID] then
		notifyPush[pID] = nil
		if pID < #notifyPush then
			for i=pID+1,#notifyPush do
				notifyPush[i-1] = notifyPush[i]
			end
			notifyPush[#notifyPush] = nil
		end
	else
		return false
	end
end

function Notify.now(pApp,pM1,pM2,pFkt)
	table.insert(notifyPush,{pApp,pM1,pM2,pFkt})
	local id = #notifyPush
	pushEvent(pApp,pM1,pM2,id)
	return true,id
end

function Notify.getNotify()
	return notifyPush
end

function Notify.execNotify(pID)
	local input = notifyPush[pID]
	if type(input[4]) == 'function' then
		input[4]()
	elseif type(input[4]) == 'string' then
		ok,err = pcall(setfenv(loadstring(input[4]),getfenv()))
	end
	remove(pID)
end

function Notify.showNotify(pBl)
	show = pBl
end

function Notify.menu()

end

function Notify.banner()
	--FrostOS only! Creates a Banner at the top of the Shell
	local w = window.create(1,1,xLen,1)
	w.setBackgroundColor(colors.black)
	w.setTextColor(colors.white)
	local wt = {} --While true table
	local function redraw()
		w.clear()
		w.setCursorPos(1,1)
		w.write("["..#notifyPush.."]")
	end
	
	local function wt.ev()
		while Notify.run do
			local ev = {os.pullEvent()}
			if ev[1] == "notify_now" then
				sleep(4)
				redraw()
			elseif ev[1] == "mouse_click" and ev[4] == 1 then
				if ev[2] == 1 then
					Notify.menu()
				else
					Notify.run = false
				end
			end
		end
	end
	
	function wt.clock()
		while Notify.run do
				local timeO = os.time()
				if timeO:len < 5 then
					timeO = "0"..timeO
				end
				w.setCursorPos(xLen-timeO:len())
				w.write(timeO)
				sleep(1)
		end
	end
	
	parallel.waitForAll(unpack(wt))
end

--[[ WIP!!!!
function watchEvents()
	return events
end

function addEvent(pApp,pM1,pM2,pFkt, ... )
	local inp = { ... }
	for i=1,#inp do
		table.insert(evNtf,inp)
	end
end

function addEventListener()
	events = true
	local a = function()
		print("Notify EventListener add!")
		while true do
			local ev = {os.pullEvent()}
			if ev == { ... } then
				notify.now(pApp,pM1,pM2,pFkt)
			end
		end
	end
	paralell.waitForAll(a,function() shell.run("shell") end)
end ]]--
