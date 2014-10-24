-- Github For ComputerCraft
-- Built for FrostOS
local github = "api.github.com"
local appdata = "/.frostos/.appdata/temp"
if superuser then
  error("Superuser program is denied because it logs programs that are executed.")
  end
if not fs.exist("/.frostos/apis/git") then
print("You don't have the git api! Installing from github...")
f = fs.open("/.frostos/apis/git", "w")
fhttp = http.get("https://raw.githubusercontent.com/MultHub/LMNet-OS/master/src/apis/git.lua")
f.write(fhttp.readAll())
f.close()
end
if not fs.exist("/.frostos/apis/ui") then
  print("Installing UI api...")
  f = fs.open("/.frostos/apis/ui", "w")
  fhttp = http.get("https://raw.githubusercontent.com/MultHub/LMNet-OS/master/src/apis/ui.lua")
  f.write(fhttp.readAll())
    f.close()
  end
os.loadAPI("/.frostos/apis/ui")
os.loadAPI("/.frostos/apis/git")
print("Please login to github before using program")
write("Username: ")
user = read()
write("Password: ")
pass = read("*")
-- Login Phase


-- table for menu
-- Options: Clone repo, Create Repo, Edit Repo.
-- In edit repo: Edit file, Change Name

