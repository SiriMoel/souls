dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local altar = GetUpdatedEntityID()
local x, y = EntityGetTransform(altar)

LoadPixelScene( "mods/tales_of_kupoli/files/phylactery/scene.png", "mods/tales_of_kupoli/files/phylactery/visual.png", x-256, y-256, "mods/tales_of_kupoli/files/phylactery/background.png", true )

x = x
y = y - 60