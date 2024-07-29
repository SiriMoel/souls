dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("data/scripts/gun/gun_actions.lua")
--dofile( "data/scripts/items/generate_shop_item.lua" )

local altar = GetUpdatedEntityID()
local x, y = EntityGetTransform(altar)

LoadPixelScene( "", "", x-15, y-0, "mods/souls/files/biome/soultrader/trader.png", true )