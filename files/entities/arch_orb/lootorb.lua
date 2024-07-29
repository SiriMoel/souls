dofile_once("mods/souls/files/scripts/utils.lua")

local orb = GetUpdatedEntityID()
local x, y = EntityGetTransform(orb)

local targets = EntityGetInRadiusWithTag(x, y, 80, "player_unit")

if #targets > 0 then
    GamePrint("orb found???")
end