dofile_once("mods/tales_of_kupoli/files/alterants.lua")

local forge = GetUpdatedEntityID()
local x, y = EntityGetTransform(forge)

LoadPixelScene( "mods/tales_of_kupoli/files/entities/ikkunaforge/s.png", "mods/tales_of_kupoli/files/entities/ikkunaforge/s_visual.png", x, y, "mods/tales_of_kupoli/files/entities/ikkunaforge/s_background.png", true )