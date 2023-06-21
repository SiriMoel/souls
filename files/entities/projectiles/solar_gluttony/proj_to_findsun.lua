dofile_once("mods/moles_things/files/scripts/utils.lua")

local entity = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity)

local sun = EntityGetInRadiusWithTag(x, y, 5, "sun")[1]
local amount = 0

if sun ~= nil then
    local sun_comp_b = EntityGetFirstComponentIncludingDisabled(sun, "VariableStorageComponent", "sun_brilliance") or 0
    local sun_b = ComponentGetValue2(sun_comp_b, "value_int")
    if sun_b * 0.1 >= 20 then
        amount = 20
    else
        amount = math.ceil(sun_b * 0.1)
    end
    sun_b = sun_b - amount
    ComponentSetValue2(sun_comp_b, "value_int", sun_b)
    local proj_from = EntityLoad("mods/moles_things/files/entities/projectiles/solar_gluttony/proj_from.xml", x, y)
    EntityAddComponent(proj_from, "VariableStorageComponent", {
        _tags="brilliance",
        name="brilliance",
        value_int=amount,
    })
    EntityKill(entity)
end