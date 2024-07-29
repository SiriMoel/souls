dofile_once("mods/souls/files/scripts/utils.lua")

local altar = GetUpdatedEntityID()
local x, y = EntityGetTransform(altar)

LoadPixelScene( "mods/souls/files/phylactery/scene.png", "mods/souls/files/phylactery/visual.png", x-256, y-256, "mods/souls/files/phylactery/background.png", true )

x = x
y = y - 60