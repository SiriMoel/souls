dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("data/scripts/gun/gun_actions.lua")
--dofile( "data/scripts/items/generate_shop_item.lua" )

local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)

LoadPixelScene( "mods/souls/files/biome/soulshop/scene.png", "", x-256, y-256, "mods/souls/files/biome/soulshop/background.png", true )