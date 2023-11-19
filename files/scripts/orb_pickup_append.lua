dofile("data/scripts/game_helpers.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local item_pickup_old = item_pickup

function item_pickup(entity_item, entity_who_picked, item_name)
    local comp_b = EntityGetFirstComponentIncludingDisabled(GetPlayer(), "VariableStorageComponent", "brilliance_stored") or 0
    local comp_bmax = EntityGetFirstComponentIncludingDisabled(GetPlayer(), "VariableStorageComponent", "brilliance_max") or 0
    local b = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(GetPlayer(),"VariableStorageComponent", "brilliance_stored") or 0, "value_int")
    local bmax =  ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(GetPlayer(), "VariableStorageComponent", "brilliance_max") or 0, "value_int")

    GiveBrilliance(comp_b, comp_bmax, 25)

    local orbcomp = EntityGetComponent( entity_item, "OrbComponent" ) or {}
    local orb_id = -1

    for key,comp_id in pairs(orbcomp) do
		orb_id = ComponentGetValueInt( comp_id, "orb_id" )
	end

    if AddRosetta(orb_id) then
       GamePrintImportant("Rosetta found!", "Check your sun tablet")
    end

    item_pickup_old(entity_item, entity_who_picked, item_name)
end