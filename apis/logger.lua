--[[ LoggerAPI ]]--

function info(input, file)
 local log = fs.open(file, "a")
 log.write("[INFO]: ".. input)
end
