os.pullEvent = os.pullEventRaw

os.loadAPI("frostos/apis/sertexapi")

sertexapi.center(2, "FrostOS")
sertexapi.center(3, "Installation")
sertexapi.center(5, "Run on startup?")

write("Y/N>")
local answer = read()
local yes = "Y"
local no = "N"
if answer == yes then
  -- Run on startup
  fs.open("/startup", "w")
  fs.write("shell.run(\"/frostos/frostos\")")
  fs.close()
  sertexapi.center(6, "Startup file created.")
elseif answer == no then
  sertexapi.center(6, "Startup file ignored.")
