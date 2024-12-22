dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)
local frame = GameGetFrameNum()

math.randomseed(x + frame, y + frame)

if math.random(1, 4) == 2 then
    EntityKill(this)
    EntityLoad("mods/souls/files/entities/items/soulrefresh/thing.xml", x, y)
end