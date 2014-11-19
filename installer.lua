local function makeToProgram(pCode,pIcon,pName,isSystemProg)
  	local Path
  	if isSystemProg then
		Path = "/FrostOS/system/"..pName
  	else
  		Path = "Programs/"..pName
  	end
  	fs.makeDir(Path)
  	
  	local code = fs.open(Path.."/startup","w")
  	code.write(pCode)
  	code.close()

  	local icon = fs.open(Path.."/icon","w")
  	icon.write(pIcon)
  	icon.close()
end

local function clear()
  term.setBackgroundColor(colors.white)
  term.clear()
  term.setCursorPos(1,1)
  term.setTextColor(colors.black)
end
 
clear()
 
textutils.slowPrint("Downloading SertexText...")
 
sertextextAPI = http.get("https://raw.githubusercontent.com/Sertex-Team/SertexText/master/src/lastest/sertextext.lua")
f = fs.open("frostos/apis/sertextext", "w")
f.write(sertextextAPI.readAll())
f.close()
 
os.loadAPI("frostos/apis/sertextext")
 
clear()
 
sertextext.center(1, "Installing FrostOS")
sertextext.center(2, "Credits: Check On GitHub @FrostOS-Team")
sertextext.center(3, "SertexText by Sertex-Team")
sertextext.center(4, "@FrostOS-Team thanks you for installing FrostOS")
os.setComputerLabel("FrostOS")
