-- This module is available to be used from vim as v:lua.f.<module>.<function>.
--
-- Members are loaded lazily from the global folder.
local M = {}

local meta = {}
function meta:__index(key) return require('global.' .. key) end

return setmetatable(M, meta)
