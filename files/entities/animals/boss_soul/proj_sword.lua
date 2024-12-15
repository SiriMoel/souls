dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)
local targets = EntityGetInRadiusWithTag(x, y, 20, "player_unit") or {}
if #targets > 0 then
    for i=1,#targets do
        if GetSoulsCount("all") > 0 then
            RemoveSoul(GetRandomSoul(true))
        end
    end
end