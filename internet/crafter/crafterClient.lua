--[[ Crafter Client ]]--
os.loadAPI("../SnowCloud/SCC")
--[[ Access The SnowCloud To See If Online ]]--
SCC.SnowCloud:SendMsg("DNR") -- A do not respond request. The SendMsg function runs SnowCloud:State() and finds out the state of the snowcloud.
