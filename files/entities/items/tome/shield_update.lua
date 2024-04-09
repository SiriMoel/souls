dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")

local tome = GetUpdatedEntityID()

local rechargespeed = 0.05

local comp_path_4 = EntityGetFirstComponentIncludingDisabled(tome, "VariableStorageComponent", "path_4") or 0
local path_4 = ComponentGetValue2(comp_path_4, "value_int")

local comp_shield = EntityGetFirstComponentIncludingDisabled(tome, "EnergyShieldComponent", "soulshield") or 0
rechargespeed = ComponentGetValue2(comp_shield, "recharge_speed")

if path_4 == 0 then
    rechargespeed = 0.1 -- unsure of scaling
    ComponentSetValue(comp_shield, "recharge_speed", tostring(rechargespeed))
end

if path_4 >= 1 and not EntityHasTag(tome, "shield_setup") then
    local pec_1 = EntityGetFirstComponentIncludingDisabled(tome, "ParticleEmitterComponent", "pec_1")
    if pec_1 ~= nil then
        ComponentAddTag(pec_1, "enabled_in_hand")
        EntitySetComponentIsEnabled(tome, pec_1, true)
    end
    local pec_2 = EntityGetFirstComponentIncludingDisabled(tome, "ParticleEmitterComponent", "pec_2")
    if pec_2 ~= nil then
        ComponentAddTag(pec_2, "enabled_in_hand")
        EntitySetComponentIsEnabled(tome, pec_2, true)
    end
    ComponentAddTag(comp_shield, "enabled_in_hand")
    EntitySetComponentIsEnabled(tome, comp_shield, true)
    --[[EntityAddComponent2(tome, "EnergyShieldComponent", {
        _tags="soulshield,enabled_in_hand,item_identified__LEGACY",
        recharge_speed="0" ,
		radius="15.0",
    })]]--
    EntityAddTag(tome, "shield_setup")

    rechargespeed = 0.1
    ComponentSetValue(comp_shield, "recharge_speed", tostring(rechargespeed))
end

if path_4 == 2 then
    rechargespeed = 0.07
    ComponentSetValue(comp_shield, "recharge_speed", tostring(rechargespeed))
end

if path_4 > 2 then
    rechargespeed = rechargespeed * path_4 -- unsure of scaling
    ComponentSetValue(comp_shield, "recharge_speed", rechargespeed)
end