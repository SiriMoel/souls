dofile_once("mods/moles_n_more/files/scripts/utils.lua")

local item_pickup_old = item_pickup

function item_pickup(entity_item, entity_who_picked, item_name)
    local comp_b = EntityGetFirstComponentIncludingDisabled(PLAYER, "VariableStorageComponent", "brilliance_stored") or 0
    local comp_bmax = EntityGetFirstComponentIncludingDisabled(PLAYER, "VariableStorageComponent", "brilliance_max") or 0
    local b = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(PLAYER,"VariableStorageComponent", "brilliance_stored") or 0, "value_int")
    local bmax =  ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(PLAYER, "VariableStorageComponent", "brilliance_max") or 0, "value_int")
    b = b + 25
    if b > bmax then
        b = bmax
    end
    ComponentSetValue2(comp_b, "value_int", b)
    item_pickup_old(entity_item, entity_who_picked, item_name)
end