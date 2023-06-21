dofile_once("mods/moles_things/files/scripts/utils.lua")

local entity = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity)

local comp_b = EntityGetFirstComponentIncludingDisabled(entity, "VariableStorageComponent", "sun_brilliance") or 0
local comp_bmax = EntityGetFirstComponentIncludingDisabled(entity, "VariableStorageComponent", "sun_brilliance_max") or 0

local b = ComponentGetValue2(comp_b, "value_int")
local bmax = ComponentGetValue2(comp_bmax, "value_int")

if b <= 0 then
    EntityKill(entity)
    EntityLoad("data/entities/projectiles/deck/explosion_giga.xml", x, y)
    local sunseaten = tonumber(GlobalsGetValue("suns_eaten"))
    sunseaten = sunseaten + 1
    GlobalsSetValue("suns_eaten", tostring(sunseaten))
end

if b > bmax then
    ComponentSetValue2(comp_b, "value_int", bmax)
end