dofile_once("mods/souls/files/scripts/utils.lua")

local altar = GetUpdatedEntityID()
local x, y = EntityGetTransform(altar)

LoadPixelScene( "mods/souls/files/biome/rainaltar/rainaltar.png", "mods/souls/files/biome/rainaltar/rainaltar_visual.png", x-256, y-256, "mods/souls/files/biome/rainaltar/rainaltar_background.png", true )
