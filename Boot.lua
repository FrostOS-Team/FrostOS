--Better known as startup
--WIP!!

--DEV
local allowRealTime = false
--/DEV

_G.xLen,_G.yLen = term.getSize()
_G.CC = {} --Table for CC Apis
local whileTrue = {}

shell.run("FrostOS/resources/bootHelper.lua")
boot.bootLogo()

--Replace ccAPIs
CC.os = {}
CC.os.version = os.version

--If not set in settings
_G.APP = {}
APP.Launcher = "FrostOS/system/Launcher"
APP.Shell = "/rom/programs/shell"
APP.Explorer = "FrostOS/system/FileExplorer"

function os.version()
	return "FrostOS 0.1"
end

CC.os.time = os.time
os.timeMode = 1 --1 = Minecraft Time, 2 = RealTime [or os.realTime]
if allowRealTime then
	os.realTime = boot.getTime()
else
	os.realTime = 0
end

function os.time()
	if os.timeMode == 1 then
		return CC.os.time()
	elseif os.timeMode == 2 then
		return os.realTime
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
		AppData.path = os.nowPath.."/data"
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
	local path
	if pProgramm:sub(1,5) == "sys/" then
		path = "FrostOS/system/"..pProgramm
	elseif pProgramm:sub(1,5) == "app:" then
		path = APP[pProgramm:sub(6,pProgramm:len())]
	else
		path = "Programs/"..pProgramm
	end

	if fs.exists(path) and fs.exists(path.."/startup") then
		os.now = pProgramm
		os.nowPath = path
		shell.run(path.."/startup", ... )
	else
		if fs.exists(pProgramm) then
			os.now = "script"
			os.nowPath = path
			shell.run(pProgramm, ... )
		else
			printError("Programm "..pProgramm.." dosn't exists")
		end
	end
	if AppData.content then
		AppData.save(true)
	end
end

function table.search(pTable,pWas)
	if type(pTable) ~= "table" then
		error("Can't search in "..type(pTable),0)
	end
	for i,v in pairs(pTable) do
		if v == pWas then
			return i
		end
	end
	for i,v in ipairs(pTable) do
		if v == pWas then
			return i
		end
	end
	return nil
end

function _G.__APPS(pApp)
	return "Programs/"..pApp.."/"
end

function _G.__SAPPS(pApp)
	return "FrostOS/system/"..pApp.."/"
end

function _G.is_table(pV)
	return type(pV) == "table"
end

function _G.is_number(pV)
	return type(pV) == "number"
end

function _G.is_string(pV)
	return string.lower(type(pV)) == "string"
end

function _G.is_program(pV)
	return fs.exists(__APPS(pV))
end

function _G.is_systemProgram(pV)
	return fs.exists(__SAPPS(pV))
end

for _,v in ipairs(whileTrue) do
	coroutine.create(v)
end

for _,v in pairs(fs.list("FrostOS/apis")) do
	os.loadAPI("FrostOS/apis/"..v)
end

_G.boot = nil
run("app:Launcher")
