--[[ SnowCloud Communicate ]]--
local SnowCloud = "5.230.233.77/fOS/SnowCloud/server.php?CC=1"

function testConnection()
 --[[ Ping Server ]]--
 
end
function SnowCloud:State()
 SnowCloudState = "Nil"
 if 
end 
function SnowCloud:SendMsg(msg)
 SnowCloudMsg = SnowCloud + "&msg=\"".. msg .. "\""
 SnowCloud:State()
 if SnowCloudState == "offline" then
  printError("The SnowCloud is offline at the moment. Please try again later.")
 elseif SnowCloudState == "Nil" then
  printError("Could not get state of the SnowCloud. Please try again later")
end
function SnowCloud:Connect()
 state = SnowCloud:SendMsg("connectclient")
 print("[SnowCloud]: Connection ".. state)
end
function SnowCloud:Stop(adminpassword)
 adminpass = SnowCloud:SendMsg("getadminpass")
 if adminpassword == adminpass then
  SnowCloud:SendMsg("stopserver")
 elseif not adminpassword == adminpass then
  error("[SnowCloud]: You do not have permissions to run this command. Reason: Invalid Password", 0)
 end
end
