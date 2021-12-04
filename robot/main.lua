local skynet = require "skynet"
require "skynet.manager"

local function main()
    skynet.error("hello zoo")
end

skynet.start(main)