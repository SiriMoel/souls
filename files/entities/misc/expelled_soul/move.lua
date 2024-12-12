dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local x, y, r, scale_x, scale_y = EntityGetTransform(this)

EntitySetTransform(this, x, y - 2, r, scale_x, scale_y)