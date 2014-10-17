--Better known as startup
--WIP!!
_G.CC = { --Table for CC Apis
	["notify"]
	} 
local whileTrue = {}

shell.run("FrostOS/bootHelpers.lua")
boot.bootlogo()

--Replace ccAPIs
CC.os = {}
CC.os.version = os.version

function os.version()
	return "FrostOS 0.1"
end

CC.os.time = os.time
os.timeMode = 1 --1 = Minecraft Time, 2 = RealTime [or os.realTime]
os.realTime = boot.getTime()

function os.time()
	if os.timeMode == 1 then
		return CC.os.time()
	elseif os.timeMode == 2 then
		return os.realTime()u
	end
end

function whileTrue.time()
	while true do
		os.realTime = os.realTime+1
		sleep(1)
	end
end

_G.AppData = {}

function AppData.load(pScript)
	if os.now == "script" and not pScript then
		return false
	elseif pScript then
		AppData.path = "Data/"..pScript
	else
		AppData.path = "Programs/"..os.now.."/data"
	end
	if fs.exists(AppData.path) then
		f = fs.open(AppData.path,"r")
		AppData.content = textutils.unserialize(f.readAll())
		f.close()
	else
		AppData.content = {}
	end
	return AppData.content
end

function AppData.save(pDel)
	f = fs.open(AppData.path,"w")
	f.write(textutils.serialize(AppData.content))
	f.close()
	if pDel then
		AppData.content = nil
		AppData.path = nil
	end
end

function _G.run(pProgramm, ... )
	local path = "Programs/"..pProgramm
	if fs.exists(path) and fs.exists(path.."/startup") then
		os.now = pProgramm
		shell.run(path.."/startup", ... )
	else
		if fs.exists(pProgramm) then
			os.now = "script"
			shell.run(pProgramm, ... )
		else
			printError("Programm "..pProgramm.." dosn't exists")
		end
	end
	if AppData.content then
		AppData.save(true)
	end
end
parallel.waitForAll(unpack(whileTrue))

for _,v in pairs(fs.list("FrostOS/apis")) do
	os.loadAPI("FrostOS/apis/"..v)
end

_G.boot = nil
run("Launcher")
