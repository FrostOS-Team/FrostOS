--[[ FrostOS System Restore 1.0 ]]--

local sysResDir = "/.FrostOS/SystemRestore/"

local filesToBeRestored = fs.list( sysResDir )

local filesToBeRestoredCount = #filesToBeRestored

local AnsNeeded = true
print( "WARNING: System restore will now restore your files to the last restore point created. The process CANNOT be interupted. " )
while AnsNeeded do
  write( "Do you want to continue? (Y/N) > " )
  ans = read()
  if ans:lower() == "y" then
    AnsNeeded = false
  elseif ans:lower() == "n" then
    printError( "Process Canceled." )
    return
  else
    printError( "Invalid Option." )
    sleep(3)
  end
end
