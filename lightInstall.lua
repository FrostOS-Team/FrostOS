--WIP - remove comment tags when complete
--[[
local files = {
  ["path"] = "url",
}

local function download()
  for k, v in pairs( files ) do
    local r
    while not r do
      r = http.get( v )
    end
    files[ k ] = r
    os.queueEvent( "download", k )
  end
end

local function save()
  while #files > 0 do
    local event, key = os.pullEvent( "download" )
    local file = fs.open( key, "w" )
    file.write( files[ key ].readAll():gsub( "[/r/n%s]+", " " ):gsub( "--.-\n", "" ) )
    file.close()
    files[ key ] = nil
  end
end

parallel.waitForAll( download, save )
]]--
