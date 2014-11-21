function runSys(path)
 if not path == path + ".sys" then
  path = path + ".sys"
 end
  if not fs.exists(path) then
   error("System File Doesn't Exist!")
 end
 shell.run("/.frostos/system/".. path)
end
