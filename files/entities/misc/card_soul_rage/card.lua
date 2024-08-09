dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

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
            RemoveSoul(GetWandSoulType(wand))
            LoadGameEffectEntityTo(player, "mods/souls/files/entities/misc/card_soul_rage/buff.xml")
        end
    else
        if GetSoulsCount("all") > 0 then
            RemoveRandomSouls(1)
            LoadGameEffectEntityTo(player, "mods/souls/files/entities/misc/card_soul_rage/buff.xml")
        end
    end
end