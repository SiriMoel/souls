dofile_once("mods/moles_n_more/files/scripts/utils.lua")

local entity = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity)

local player = EntityGetInRadiusWithTag(x, y, 200, "player_unit")[1]

if player ~= nil then
    local comp_b = EntityGetFirstComponentIncludingDisabled(entity, "VariableStorageComponent", "brilliance") or 0
    local comp_bmax = EntityGetFirstComponentIncludingDisabled(entity, "VariableStorageComponent", "brilliance_max") or 0

    local p_comp_b = EntityGetFirstComponentIncludingDisabled(GetPlayer(), "VariableStorageComponent", "brilliance_stored") or 0
    local p_comp_bmax = EntityGetFirstComponentIncludingDisabled(GetPlayer(), "VariableStorageComponent", "brilliance_max") or 0

    local b = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(entity, "VariableStorageComponent", "brilliance") or 0, "value_int")
    local bmax =  ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(entity, "VariableStorageComponent", "brilliance_max") or 0, "value_int")
    local p_b = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(GetPlayer(),"VariableStorageComponent", "brilliance_stored") or 0, "value_int")
    local p_bmax =  ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(GetPlayer(), "VariableStorageComponent", "brilliance_max") or 0, "value_int")

    local new_b = p_b + b
    if new_b > p_max then
        new_b = p_max
    end
    
    ComponentSetValue2(p_comp_b, "value_int", new_b)
end