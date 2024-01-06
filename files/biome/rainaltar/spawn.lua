dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local altar = GetUpdatedEntityID()
local x, y = EntityGetTransform(altar)

LoadPixelScene( "mods/tales_of_kupoli/files/biome/rainaltar/rainaltar.png", "mods/tales_of_kupoli/files/biome/rainaltar/rainaltar_visual.png", x-256, y-256, "mods/tales_of_kupoli/files/biome/rainaltar/rainaltar_background.png", true )
