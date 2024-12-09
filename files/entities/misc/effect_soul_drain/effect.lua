dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)
local player = GetPlayer()

if root == player then
    if (GetSoulsCount("all") - GetSoulsCount("boss")) > 0 then
        local soul = GetRandomSoul(false)
        RemoveSoul(soul)
    end
end