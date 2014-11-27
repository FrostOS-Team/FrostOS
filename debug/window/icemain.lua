local tApps = {}

function drawDock( bColor, tColor )
	local x, y = term.getSize()
	term.setBackgroundColor( bColor )
	term.setTextColor( tColor )
	for i = 1, y do
		term.setCursorPos( 1, i )
		term.write( '   ' )
	end
	local y = 2
	for k, v in pairs( tApps ) do
		v:showIcn( 1, y )
		y = y + 2
	end
end

local app = {
	getName = function( self )
		return self.name
	end,
	getWindow = function( self )
		return self.window
	end,
	getStatus = function( self )
		return coroutine.status( self.co )
	end,
	resume = function( self, ... )
		return coroutine.resume( self.co, ... )
	end,
	showIcn = function( self, x, y )
		paintutils.drawImage( self.icn, x, y )
	end
}

function launch( sFile, sIcn, ... )
	if not fs.exists( sFile ) then
		error( "No such file: " .. sFile, 2 )
	end
	local file = fs.open( sFile, "r" )
	local data = file.readAll()
	file.close()
	local func, err = loadstring( data )
	if not func then
		error( err, 0 )
	end
	local new = {
		name = sFile,
		window = icewindow.init( term.current(), 4, 4, 20, 10, sFile ),
		co = coroutine.create( func ),
		icn = paintutils.loadImage( sIcn )
	}
	local origin = term.current()
	term.redirect( new.window )
	new.sFilter = coroutine.resume( new.co )
	term.redirect( origin )
	setmetatable( new, { __index = app })
	tApps[#tApps+1] = new
	icewindow.drawToolBar(new,colors.blue,colors.lightBlue)
	return new
end

function run()
	local origin = term.current()
	local tFilters = {}
	local event = {}
	while #tApps > 0 do
		for i, app in ipairs( tApps ) do
			if app.sFilter then
				tFilters[ i ] = app.sFilter
				app.sFilter = nil
			end
			if (not tFilters[ i ] or event[ 1 ] == tFilters[ i ] or event[ 1 ] == "terminate") and app:getStatus() == "suspended" then
				term.redirect( app:getWindow() )
				tFilters[ i ] = app:resume( unpack( event ) )
				term.redirect( term.current() )
				app.tArgs = nil
			elseif app:getStatus() == "dead" then
				table.remove( tApps, i )
				table.remove( tFilters, i )
			end
		end
		event = { os.pullEvent }
	end
end
