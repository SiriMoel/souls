dofile_once("mods/souls/files/alterants.lua")

local forge = GetUpdatedEntityID()
local x, y = EntityGetTransform(forge)

LoadPixelScene( "mods/souls/files/entities/ikkunaforge/s.png", "mods/souls/files/entities/ikkunaforge/s_visual.png", x, y, "mods/souls/files/entities/ikkunaforge/s_background.png", true )