dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("data/scripts/gun/gun_actions.lua")
--dofile( "data/scripts/items/generate_shop_item.lua" )

local altar = GetUpdatedEntityID()
local x, y = EntityGetTransform(altar)

LoadPixelScene( "mods/tales_of_kupoli/files/biome/souldoor/scene.png", "mods/tales_of_kupoli/files/biome/souldoor/visual.png", x-256, y-256, "mods/tales_of_kupoli/files/biome/souldoor/background.png", true )

--EntityLoad("mods/tales_of_kupoli/files/biome/souldoor/exchanger_location.png", x, y-60)

x = x
y = y - 60