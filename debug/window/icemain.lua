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
        return coroutine.getStatus( self.co )
    end,
    resume = function( self, ... )
        coroutine.resume( self.co, ... )
        self:getWindow().redraw()
    end,
}

function launch( sFile )
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
        window = icewindow.init( term.current(), 3, 1, 20, 10, sFile ),
        co = coroutine.create( func ),
    }
    setmetatable( new, app )
    tApps[ #tApps + 1 ] = new
    return new
end

function run()
    while true do
        local event = { os.pullEvent() }
        for i, app in ipairs( tApps ) do
            if app:getStatus() == "suspended" then
                app:resume( unpack( event ) )
            elseif app:getStatus() == "dead" then
                table.remove( tApps, i )
            end
        end
    end
end
