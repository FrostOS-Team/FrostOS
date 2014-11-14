--[[
Frost Antivirus
Developed for FrostOS but can be used in anything (including CraftOS)
--]]
local virusdatabase = fs.open(http.get(https://raw.githubusercontent.com/FrostOS-Team/FrostAntiVirus-Database/master/virus.data), "r")
ver = "0.1"
database = virusdatabase.readLine()
virusdatabase.close()
print("Frost Antivirus ".. ver)
print("Database Version ".. database)
if database > dldatabase then
 print("Outdated Database! Downloading latest virus database...")
 local dldatabase = fs.open("/database/virus.data", "w")
 dldatabase.write(http.get(https://raw.githubusercontent.com/FrostOS-Team/FrostAntiVirus-Database/master/virus.data).readAll())
 dldatabase.close()
 print("Downloaded latest database!")
end
if FrostOS then 
 print("FrostOS found! Will scan directories")
end
print("Running antivirus...")

print("Scanning")
