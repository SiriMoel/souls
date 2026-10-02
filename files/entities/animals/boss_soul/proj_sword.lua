dofile_once("mods/souls/files/scripts/souls.lua")
local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)
local targets = EntityGetInRadiusWithTag(x, y, 18, "player_unit") or {}
if #targets > 0 then
    LoseSouls(targets[1], 1)
end