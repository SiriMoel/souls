dofile_once("mods/souls/files/scripts/souls.lua")
local entity = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity)
local targets = EntityGetInRadiusWithTag(x, y, 25, "player_unit") or {}
if #targets > 0 then
    LoseSouls(targets[1], 1)
end