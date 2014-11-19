os.pullEvent = os.pullEventRaw

os.loadAPI("frostos/apis/sertextext")

function setup()

sertextext.center(2, "FrostOS")
sertextext.center(3, "Setup")
sertextext.center(5, "Run on startup?")
print("")
write("Y/N>")
local answer = read()
local yes = "Y"
local no = "N"
if answer == yes then
  -- Run on startup
  local h = fs.open("/startup", "w")
  h.write("shell.run(\"/frostos/frostos\")")
  h.close()
  sertextext.center(6, "Startup file created.")
elseif answer == no then
  -- Don't create file
  sertextext.center(6, "Startup file not created.")
end

end

setup()
