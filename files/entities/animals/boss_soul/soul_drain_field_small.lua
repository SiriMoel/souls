dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local entity_id = GetUpdatedEntityID()
local root_id = EntityGetRootEntity( entity_id )
local x, y = EntityGetTransform( entity_id )

local targets = EntityGetInRadiusWithTag(x, y, 25, "player_unit") or {}

if #targets > 0 then
    for i=1,#targets do
        if GetSoulsCount("all") > 0 then
            RemoveSoul(GetRandomSoul(true))
        end
    end
end