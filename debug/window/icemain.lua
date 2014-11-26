local tApps = {}

function drawDock( bColor, tColor )
	local x, y = term.getSize()
	term.setBackgroundColor( bColor )
	term.setTextColor( tColor )
	for i = 1, y do
		term.setCursorPos( 1, i )
		term.write( '   ' )
	end
	local y = 3
	for k, v in pairs( tApps ) do
		term.setCursorPos( 1, y )
		term.write( v:getName():sub( 1, 3 ) )
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
		local sFilter = coroutine.resume( self.co, ... )
		self:getWindow().redraw()
		return sFilter
	end,
}

function launch( sFile, ... )
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
		co = coroutine.create( func end ),
		tArgs = { ... }
	}
	setmetatable( new, { __index = app })
	tApps[ #tApps + 1 ] = new
	icewindow.drawToolBar( new, colors.blue, colors.lightBlue )
	return new
end

function run()
	local origin = term.current()
	local tFilters = {}
	local event = {}
	while true do
		for i, app in ipairs( tApps ) do
			if (not tFilters[ i ] or event[ 1 ] == tFilters[ i ] or event[ 1 ] == "terminate") and app:getStatus() == "suspended" then
				term.redirect( app:getWindow() )
				local choice = app.tArgs or event
				tFilters[ i ] = app:resume( unpack( choice ) )
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
