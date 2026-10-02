dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

function damage_about_to_be_received(damage, x, y, entity_thats_responsible, critical_hit_chance)
    local player = GetUpdatedEntityID()
    local helditem = HeldItem(player)
    if damage > 0 then
        for i,v in ipairs(GameGetAllInventoryItems(player) or {}) do
            if EntityHasTag(v, "souls_item_take_more_damage") then
                damage = damage * 1.5
                break
            end
        end
        if EntityHasTag(helditem, "souls_deadringer") then
            local comp_cd = EntityGetFirstComponentIncludingDisabled(helditem, "VariableStorageComponent", "deadringer_cd") or 0
            local cd = ComponentGetValue2(comp_cd, "value_int")
            if cd <= 0 then
                if (GetSoulsCount("all") - GetSoulsCount("boss")) >= 10 then
                    RemoveRandomSouls(10)
                    local effects_to_remove = { "WET", "OILY", "BLOODY", "RADIOACTIVE", "ON_FIRE" }
                    for i,v in ipairs(effects_to_remove) do
                        EntityRemoveStainStatusEffect(player, v)
                    end
                    LoadGameEffectEntityTo(player, "mods/souls/files/entities/items/deadringer/buff.xml")
                    ComponentSetValue2(comp_cd, "value_int", 900)
                    GamePrint("Feigned death!")
                    GamePlaySound("data/audio/Desktop/explosions.bank", "explosions/electric", x, y)
                    LoadRagdoll("data/ragdolls/player/filenames.txt" , x, y-5)
                    return 0, 0
                else
                    return damage, critical_hit_chance
                end
            else
                return damage, critical_hit_chance
            end
        end
        local inv_items = GameGetAllInventoryItems(player) or {}
        if #inv_items > 0 then
            for i, v in ipairs(inv_items) do
                if EntityHasTag(v, "souls_phylactery") then
                    local comp_p = EntityGetFirstComponentIncludingDisabled(v, "VariableStorageComponent", "phylactery")
                    if comp_p ~= nil then
                        local p = ComponentGetValue2(comp_p, "value_int")
                        if p > 0 then
                            ComponentSetValue2(comp_p, "value_int", p - 1)
                            local x, y = EntityGetTransform(player)
                            GamePlaySound("data/audio/Desktop/projectiles.bank", "projectiles/enlightened_laser/launch_dark", x, y) -- placeholder probably
                            return 0, 0
                        end
                    end
                end
            end
        end
    end
    return damage, critical_hit_chance
end