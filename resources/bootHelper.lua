--Store additonal functions here. Will set to nil at the end of boot/startup
_G.boot = {}
function boot.getTime()
	local adress = "http://5.230.233.77/fOS/time"
	local req = http.get(adress)
	if req then
		os.online = true
		return tonumber(req.readAll())
	else
		error("Can't access FrostOS Server!",0)
		os.online = false
	end
end

function boot.loadSysFiles()
 sysPath = "/.frostos/system"
 local FileList = fs.list(sysPath)

for _, file in ipairs(FileList) do
  shell.run(file) 
 end
end

function boot.bootLogo()
	local flakes, ok = {}, true
	local maxx, maxy = term.getSize()
	for i = 1, maxx, 3 do
	    flakes[ i + math.random( 0, 2 ) ] = { cx = math.random( 1, maxy ), lx = 0 }
	end
	term.setTextColor( colors.white )
	term.setBackgroundColor( colors.lightBlue )
	term.clear()
	local frost = paintutils.loadImage( "/images/.frost" )
	while ok do
	    term.setTextColor( colors.white )
	    term.setBackgroundColor( colors.lightBlue )
	    for i, flake in pairs( flakes ) do
	        term.setCursorPos( i, flake.lx )
	        term.write( ' ' )
	        term.setCursorPos( i, flake.cx )
	        term.write( i % 2 == flake.cx % 2 and "*" or "%" )
	        flake.lx = flake.cx
	        flake.cx = flake.cx + 1
	        if flake.cx > maxy then
	            flake.cx = 1
	        end
	    end
	    term.setCursorPos( 4, 12 )
	    term.setTextColor( colors.blue )
	    term.write( "Press any key to continue" )
	    paintutils.drawImage( frost, 1, 1 )
	    local t = os.startTimer( 0.2 )
	    while true do
	        local event, param = os.pullEvent()
	        if event == "timer" and param == t then
	            break
	        elseif event == "key" then
	            ok = false
	            break
	        end
	    end
	end
end

function boot.loadSettings()

end
