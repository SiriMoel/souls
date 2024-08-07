dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")

local card = GetUpdatedEntityID()
local root = EntityGetRootEntity(card) -- player, right?

local player = GetPlayer()
local wand = HeldItem(player)

if root == player then
    local comp_damagemodel = EntityGetFirstComponentIncludingDisabled(root, "DamageModelComponent") or 0
    local hp = ComponentGetValue2(comp_damagemodel, "hp")
    local hp_max = ComponentGetValue2(comp_damagemodel, "max_hp")

    if DoesWandUseSpecificSoul(wand) then
        if GetSoulsCount(GetWandSoulType(wand)) > 0 then
            hp = hp * 1.03
            if hp >= hp_max then
                hp = hp_max
            else
                RemoveSoul(GetWandSoulType(wand))
            end
            ComponentSetValue2(comp_damagemodel, "hp", hp)
        end
    else
        if GetSoulsCount("all") > 0 then
            hp = hp * 1.03
            if hp >= hp_max then
                hp = hp_max
            else
                RemoveRandomSouls(1)
            end
            ComponentSetValue2(comp_damagemodel, "hp", hp)
        end
    end
end