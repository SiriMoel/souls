dofile_once("mods/moles_n_more/files/scripts/utils.lua")

local entity = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity)

local proj_main = EntityGetInRadiusWithTag(x, y, 5, "solar_gluttony")[1]

if proj_main ~= nil then
    local b = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(entity, "VariableStorageComponent", "brilliance") or 0, "value_int")
    TransferBrilliance(EntityGetFirstComponentIncludingDisabled(entity, "VariableStorageComponent", "brilliance") or 0, EntityGetFirstComponentIncludingDisabled(proj_main, "VariableStorageComponent", "brilliance") or 0, EntityGetFirstComponentIncludingDisabled(proj_main, "VariableStorageComponent", "brilliance_max") or 0, b)
    EntityKill(entity)
end