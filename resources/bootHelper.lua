--Store additonal functions here. Will set to nil at the end of boot/startup
_G.boot = {}
function boot.getTime()
	local adress = "http://5.230.233.77/fOS/time"
	local req = http.get(adress)
	if req then
		os.online = true
		return tonumber(req.readAll())
	else
		error("Can't acsess FrostOS Server!",0)
		os.online = false
	end
end

function boot.bootLogo()

end
