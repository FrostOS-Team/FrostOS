--[[ Crashing Screen ( aka a BSOD ) ]]--
--[[ Needs to stay running... use parallel.waitForAny( function()
  shell.run( "/system/crash.sys" )
end,
function()
  shell.run( "/startup" )
end )
--]]


local BSODtheme = {}
local BSODErrorCodes = {
[ "Program Error" ] = "STOP 00000x1C\nThis Error Means That The Program\nEncountered A Problem.",
[ "System Error" ] = "STOP 00000x1F\nThis Error Means That FrostOS\nEncountered A System Error",
[ "Unknown" ] = "STOP 00000x0\nThis Error Means That FrostOS\nDoesn't Know What Happened",
}
function shiftAll() --[[ Thanks @KingofGamesYami ]]--
local nMax, tDumps = 0, fs.list( "/dumps" )
  for k, v in pairs( tDumps ) do
    local n = v:match( "BSOD(%d+).dmp" )
    if n > nMax then
      n = nMax
    end
  end
  for i = nMax, 1, -1 do
   fs.move( "BSOD" .. i .. ".dmp", "BSOD" .. (i + 1) .. ".dmp" )
  end
end
function clear()
  term.clear()
  term.setCursorPos( 1,1 )
end
function cprint(sText)
    local w, h = term.getSize()
    local x, y = term.getCursorPos()
    x = math.max(math.floor((w / 2) - (#sText / 2)), 0)
    term.setCursorPos(x, y)
    print(sText)
end
function setBSODtheme( background, foreground )
  BSODtheme[1] = background
  BSODtheme[2] = foreground
end
while true do
  local e = { os.pullEventRaw( "bsod" ) }
  if e[1] == "bsod" then
    clear()
    setBSODtheme( colors.blue, colors.white )
    term.setBackgroundColor(BSODtheme[1])
    term.setTextColor(BSODtheme[2])
    cprint( "------------ FrostOS Crash Report ------------" )
    cprint( "An error has occurred and FrostOS has shut down." )
    cprint( "Please report this crash as an issue in the Github" )
    cprint( " Repo as an issue, labeled \"Crash\". The file you" )
    cprint( "want to upload is the \"BSOD1.dmp\" file. Not the" )
    cprint( "ones with higher numbers like \"BSOD20.dmp\" because" )
    cprint( "they are old ones. A dump file will be generated..." )
    shiftAll()
    f = fs.open( "/dumps/BSOD1.dmp", "w" )
    f.write( "------------ FrostOS Crash Dump ------------\n" )
    f.write( "You will find the rest of the crash report here! " )
     if e[2] == "program" then
      f.write( BSODErrorCodes[ "Program Error" ] )
     elseif e[2] == "system" then
      f.write( BSODErrorCodes[ "System Error" ] )
     else
       f.write( BSODErrorCodes[ "Unknown" ] )
    end
    f.close()
    cprint( "Finished generating dump file. Rebooting..." )
    sleep( 3 )
    os.reboot()
  end
end
