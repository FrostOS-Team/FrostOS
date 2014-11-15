--[[
Frost Antivirus
Developed for FrostOS but can be used in anything (including CraftOS)
--]]
w, h = term.getSize()
ver = "0.1"
term.setCursorPos(w, h)
write("Connecting to github... ")
local virusdatabase = http.get("https://raw.githubusercontent.com/FrostOS-Team/FrostAntiVirus-Database/master/virus.data")
term.setTextColor(colors.green)
write("[ok]")
term.setTextColor(colors.white)
if fs.exists("/database/virus.data") == true then
 term.setCursorPos(w, h)
 write("Deleting old database...")
 fs.delete("/database/virus.data")
 term.setTextColor(colors.green)
 write("[ok]")
 term.setTextColor(colors.white)
end
local dl = fs.open("/database/virus.data", "w")
dl.write(virusdatabase.readAll())
dl.close()
term.setCursorPos(w, h)
print("Frost Antivirus ".. ver)
if FrostOS then 
 print("FrostOS found! Will scan directories")
end
print("Running antivirus...")

print("Scanning")
local data2 = fs.open("/.appdata/temp/virus.data", "r")
local data = fs.open("/database/virus.data")
data2.write(textutils.serialize(data))
data2.close()
data.close()
