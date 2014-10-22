-- Github For ComputerCraft
-- Built for FrostOS
local github = "api.github.com"
if fs.exist("/.frostos/apis/git") then
print("You don't have the git api! Installing from github...")
f = fs.open("/.frostos/apis/git", "w")
fhttp = http.get("https://raw.githubusercontent.com/MultHub/LMNet-OS/master/src/apis/git.lua")
f.write(fhttp.readAll())
f.close()
end
