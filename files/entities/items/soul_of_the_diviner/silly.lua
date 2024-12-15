dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)

local targets = EntityGetInRadiusWithTag(x, y, 120, "projectile_player") or {}

for i=1,#targets do
    local proj = targets[i]
    local comp_proj = EntityGetFirstComponentIncludingDisabled(proj, "ProjectileComponent")
    if comp_proj ~= nil then
        ComponentSetValue2(comp_proj, "damage", 0)
    end
end