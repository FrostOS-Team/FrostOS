--[[
Frost Antivirus
Developed for FrostOS but can be used in anything (including CraftOS)
--]]
ver = "0.1"
print("Frost Antivirus".. ver)
if FrostOS then 
 print("FrostOS found! Will scan directories")
end
print("Running antivirus...")
virus1 = "PAWN"
virus2 = "N00B"
virus3 = "os.reboot()"
virus4 = "os.shutdown()"
virusSpread1 = "function infect()"
virusSpread2 = "fs.write(\"print(\"Infected\"))"
virusSpread3 = "shell.run(\"cp", "startup", "/disk/startup\")"

print("Scanning")
