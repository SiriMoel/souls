dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local valk = GetUpdatedEntityID()

local comp_areadamage = EntityGetFirstComponentIncludingDisabled(valk, "AreaDamageComponent") or 0

if comp_areadamage ~= 0 then
    ComponentSetValue2(comp_areadamage, "entity_responsible", valk)
end

print("Valkoinen spawned")