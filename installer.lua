function clear()
  term.setBackgroundColor(colors.white)
  term.clear()
  term.setCursorPos(1,1)
  term.setTextColor(colors.black)
end
 
clear()
 
textutils.slowPrint("Downloading SertexAPI...")
 
sertexapiDownload = http.get("https://raw.githubusercontent.com/Sertex-Team/sertexos/master/sertexapi.lua")
f = fs.open("frostos/apis/sertexapi", "w")
f.write(sertexapiDownload.readAll())
f.close()
 
os.loadAPI("frostos/apis/sertexapi")
 
clear()
 
sertexapi.center(1, "Installing FrostOS")
sertexapi.center(2, "Credits: Check On GitHub @FrostOS-Team")
sertexapi.center(3, "SertexAPI by Sertex-Team")
sertexapi.center(4, "@FrostOS-Team thanks you for installing FrostOS")
os.setComputerLabel("FrostOS")