dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local card = GetUpdatedEntityID()
local root = EntityGetRootEntity(card) -- player, right?

if root == GetPlayer() then
    local comp_damagemodel = EntityGetFirstComponentIncludingDisabled(root, "DamageModelComponent") or 0
    local hp = ComponentGetValue2(comp_damagemodel, "hp")
    local hp_max = ComponentGetValue2(comp_damagemodel, "max_hp")
    if GetSoulsCount("all") > 0 then
        hp = hp * 1.03
        if hp >= hp_max then
            hp = hp_max
        else
            RemoveSouls(1)
        end
        ComponentSetValue2(comp_damagemodel, "hp", hp)
    end
end