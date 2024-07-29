dofile_once("mods/souls/files/scripts/utils.lua")

local altar = GetUpdatedEntityID()
local x, y = EntityGetTransform(altar)

LoadPixelScene( "mods/souls/files/biome/sillychest/sillychest.png", "mods/souls/files/biome/sillychest/sillychest_visual.png", x-256, y-256, "", true )

EntityLoad("mods/souls/files/biome/sillychest/chest.xml", x, y-20)