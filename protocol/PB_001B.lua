--------------------------------------------------------------------------------
-- Description: self defined protocol，server to client protocol format：
--                  | len   | id    | error code| data |
--                  | 16bit | 16bit | 16bit     | ~    |
--
-- Protocol ID: PB_001B
-- Author:      hehanjing
-- Email:       hehehunanchina@live.com
-- Date:        2021-10-9 17:30:48
--------------------------------------------------------------------------------

local protobuf = require "protobuf"

local M = {}

local _id_map = {}

function M.pack(name, id, retain, err, msg)
    _id_map[id] = name
    local buf = protobuf.encode(name, msg)
    local len = #buf + 2 + 2 + 2
    return string.pack(">HHHH", len, id, retain, err) .. buf
end

function M.unpack(package)
    local len, id, retain, err, _ = string.unpack(">HHHH", package)
    len  = len + 2

    local name = _id_map[id]
    local start = 1 + 2 + 2 + 2 + 2
    local buf = string.sub(package, start, len)
    local msg = protobuf.decode(name, buf)
    return id, retain, err, msg
end

function M.forward()
    return 2
end

return M