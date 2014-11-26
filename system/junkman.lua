local files = "/"
local FrostDir = "/.frostos"
function clear()
 term.clear()
 term.setCursorPos(1,1)
end
function centerText(text)
 local x,y = term.getSize()
 local x2,y2 = term.getCursorPos()
 term.setCursorPos(math.ceil((x / 2) - (text:len() / 2)), y2)
 write(text)
end
clear()
term.setBackgroundColor(colors.red)
centerText("Junk Manager")
term.setCursorPos(1,2)
centerText("Scanning for duplicate files...")
local FileList = fs.list("/")

for _, file in ipairs(FileList) do
 term.setBackgroundColor(colors.red)
 count = 3
 term.setCursorPos(1,count)
 centerText("Analizying: " .. file)
 --[[ Alalization ]]--
 count = count + 1
end
