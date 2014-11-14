local tArgs = {...}
if #tArgs[1] == "-pkg" then
 if #tArgs[2] == "" then
  print("No package defined in -pkg flag. Your package installer is invalid.")
  return "Invalid"
 end
 --[[ Deal with all packages ]]--
 local pkg == #tArgs[2]
 print("Finding Package: ".. pkg)
 if fs.exists(pkg) == true then
   print("Package found")
   local pkg2 = textutils.serialize(pkg)
   --[[ Check for valid package]]--
   -- if pkg2 == false then
    --print(pkg2 .." is an invalid package file. Please contact the package author")
    --return "Invalid"
   --end
end
