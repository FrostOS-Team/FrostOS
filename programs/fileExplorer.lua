local args = { ... } 
-- File Explorer for FrostOS
local data = AppData.load()
local Path = args[1] or "/"
local inPath
local folders,files = {},{}

if not data.savedFolder then
	data.savedFolder = {
	["/"] = "/",
	[user] = "home/"..user,
	["Programs"] = "Programs",
	["system"] = "FrostOS",
	}
end

function loadPath(nPath)
	if nPath then
		Path = nPath
	end
	inPath = fs.list(Path)
	folders,files = {},{}
	for _,v in pairs(inPath) do
		if fs.isDir(Path.."/"..v) then
			table.insert(folders,v)
		else
			table.insert(files,v)
		end
	end
end

