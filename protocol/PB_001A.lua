--------------------------------------------------------------------------------
-- Description: self defined protocol，client to server, protocol format：
--                  | len   | id    | msg  |
--                  | 16bit | 16bit | ~    |
--
-- Protocol ID: PB_001A
-- Author:      hehanjing
-- Email:       hehehunanchina@live.com
-- Date:        2021-10-9 17:30:48
--------------------------------------------------------------------------------

local protobuf = require "protobuf"

local M = {}

local _id_map = {}

function M.pack(name, id, msg)
    _id_map[id] = name
    local buf   = protobuf.encode(name, msg)
    local len   = #buf + 2 + 2
    return string.pack(">HH", len, id) .. buf
end

function M.unpack(package)
    local len, id, _ = string.unpack(">HH", package)
    len  = len + 2

    local name  = _id_map[id]
    local buf   = string.sub(package, 1 + 2 + 2, len)
    local msg   = protobuf.decode(name, buf)
    return id, msg
end

function M.forward()
    return 2
end

return M