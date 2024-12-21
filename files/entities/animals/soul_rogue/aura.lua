dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)

local targets = EntityGetInRadiusWithTag(x, y, 72, "soul_projectile")

if #targets > 0 then
    for i,target in ipairs(targets) do
        EntityKill(target)
    end
end