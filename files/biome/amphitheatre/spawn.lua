dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("data/scripts/gun/gun_actions.lua")

local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)

LoadPixelScene( "mods/souls/files/biome/amphitheatre/scene.png", "mods/souls/files/biome/amphitheatre/visual.png", x-256, y-256, "mods/souls/files/biome/amphitheatre/background.png", true )

x = x
y = y - 30

EntityLoad("mods/souls/files/biome/amphitheatre/thing.xml", x, y)