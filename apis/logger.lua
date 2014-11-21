--[[ LoggerAPI ]]--

function info(input, file)
 local log = fs.open(file, "a")
 log.write("[INFO]: ".. input)
end

function warn(input, file)
 local log = fs.open(file, "a")
 log.write("[WARN]: ".. input)
end

function error(input, file)
 local log = fs.open(file, "a")
 log.write("[ERROR]: ".. input)
end
