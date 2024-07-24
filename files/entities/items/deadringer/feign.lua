dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")

local item = GetUpdatedEntityID()

local comp_cd = EntityGetFirstComponentIncludingDisabled(item, "VariableStorageComponent", "deadringer_cd") or 0
local cd = ComponentGetValue2(comp_cd, "value_int")

local comp_item = EntityGetFirstComponentIncludingDisabled(item, "ItemComponent") or 0

local player = GetPlayer()

local player_hp = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(player, "DamageModelComponent") or 0, "hp")

if cd <= 0 then
    if GetSoulsCount("all") >= 10 then
        if player_hp < ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(item, "VariableStorageComponent", "player_health_old") or 0, "value_int") then
            RemoveSouls(10)
            LoadGameEffectEntityTo(player, "mods/tales_of_kupoli/files/entities/items/deadringer/buff.xml")
            ComponentSetValue2(comp_cd, "value_int", 480)
        end
    end
end