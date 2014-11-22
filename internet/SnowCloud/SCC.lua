--[[ SnowCloud Communicate ]]--
local SnowCloud = "5.230.233.77/fOS/SnowCloud/server.php?CC=1"
os.loadAPI("/.frostos/apis/SHA-256")
function SnowCloud:State()
 SnowCloudState = "Nil"
 if --[[ Ping Server == True ]]-- then
  SnowCloudState = "online"
 elseif --[[ If there is no connection ]]-- then
  SnowCloudState = "offline"
 elseif --[[ Connection Timed Out ]]-- then
  SnowCloudState = "timeout"
end 
function SnowCloud:SendMsg(msg)
 SnowCloudMsg = SnowCloud + "&msg=\"".. msg .. "\""
 SnowCloud:State()
 if SnowCloudState == "offline" then
  printError("The SnowCloud is offline at the moment. Please try again later.")
 elseif SnowCloudState == "Nil" then
  printError("Could not get state of the SnowCloud. Please try again later.")
 elseif SnowCloudState == "timeout" then
  printError("The SnowCloud connection timed out. Please try again later.")
 elseif SnowCloudState == "online" then
  http.post(SnowCloud, SnowCloudMsg)
 end
end
function SnowCloud:Connect()
  SnowCloud:State()
 if SnowCloudState == "offline" then
  printError("The SnowCloud is offline at the moment. Please try again later.")
 elseif SnowCloudState == "Nil" then
  printError("Could not get state of the SnowCloud. Please try again later.")
 elseif SnowCloudState == "timeout" then
  printError("The SnowCloud connection timed out. Please try again later.")
 elseif SnowCloudState == "online" then
  http.post(SnowCloud, SnowCloudMsg)
  state = SnowCloud:SendMsg("connectclient")
  print("[SnowCloud]: Connection ".. state)
 end
end
function SnowCloud:Stop(adminpassword)
 adminpass = SnowCloud:SendMsg("getadminpass")
 SHA-256.sha256(adminpassword)
 if adminpassword == adminpass then
  SnowCloud:SendMsg("stopserver")
 elseif not adminpassword == adminpass then
  error("[SnowCloud]: You do not have permissions to run this command. Reason: Invalid Password", 0)
 end
end
