dofile_once("mods/moles_n_more/files/scripts/utils.lua")

local entity = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity)

local b = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(entity, "VariableStorageComponent", "brilliance") or 0, "value_int")
local bmax =  ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(entity, "VariableStorageComponent", "brilliance_max") or 0, "value_int")

local suns = EntityGetInRadiusWithTag(x, y, 100, "sun")

if suns ~= nil and #suns > 1 and b < bmax then
    -- launch
end