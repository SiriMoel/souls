dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local altar = GetUpdatedEntityID()
local x, y = EntityGetTransform(altar)

LoadPixelScene( "mods/tales_of_kupoli/files/biome/sillychest/sillychest.png", "mods/tales_of_kupoli/files/biome/sillychest/sillychest_visual.png", x-256, y-256, "", true )

EntityLoad("mods/tales_of_kupoli/files/biome/sillychest/chest.xml", x, y-20)