dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")

local tome = GetUpdatedEntityID()

local rechargespeed = 1.0

local comp_path_4 = EntityGetFirstComponentIncludingDisabled(tome, "VariableStorageComponent", "path_4") or 0
local path_4 = ComponentGetValue2(comp_path_4, "value_int")

local comp_shield = EntityGetFirstComponentIncludingDisabled(tome, "EnergyShieldComponent", "soulshield") or 0

if path_4 == 1 and EntityHasTag(tome, "shield_setup") then
    local targets = EntityGetAllComponents(tome)
    for i,v in ipairs(targets) do
        if ComponentHasTag(v, "soulshield") then
            EntitySetComponentIsEnabled(tome, v, true)
        end
    end
end

if path_4 >= 1 then
    rechargespeed = rechargespeed / ( path_4 * 0.3 ) -- unsure of scaling
    ComponentSetValue(comp_shield, "recharge_speed", rechargespeed) 
end