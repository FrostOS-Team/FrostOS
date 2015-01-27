--[[ Used for program developers who need to manipulate FrostOS ]]--
function runSys(path)
 --[[--
 if not path == path + ".sys" then
  path = path + ".sys"
 end
 
 if not path == "/.frostos/system/" + path then
  path = "/.frostos/system/" + path
 end
 --]]--
  if not fs.exists(path) then
   error("System File Doesn't Exist!")
 end
 shell.run(path)
end

function version()
 return "v1.0 Alpha"
end
