local tArgs = {...}
if #tArgs[1] == "-pkg" then
 if #tArgs[2] == "" then
  print("No package defined in -pkg flag. Your package installer is invalid or corrupt.")
 end
end
