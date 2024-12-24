dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

function damage_about_to_be_received(damage, x, y, entity_thats_responsible, critical_hit_chance )
    local player = GetUpdatedEntityID()
    local helditem = HeldItem(player)
    if damage > 0 then
        for i,v in ipairs(GameGetAllInventoryItems(player) or {}) do
            if EntityHasTag(v, "souls_item_take_more_damage") then
                damage = damage * 1.5
                break
            end
        end
        local soul_emulator_state = GlobalsGetValue("souls.soul_emulator_state", "0")
        if soul_emulator_state == "1" then
            local comp_damagemodel = EntityGetFirstComponentIncludingDisabled(player, "DamageModelComponent") or 0
            local max_hp = ComponentGetValue2(comp_damagemodel, "max_hp")
            if damage >= max_hp then
                GlobalsSetValue("souls.soul_emulator_state", "2")
                EntityLoad("mods/souls/files/entities/misc/expelled_soul/thing.xml", x, y)
                GamePlaySound("data/audio/Desktop/misc.bank", "misc/chest_dark_open", x, y)
                GamePlaySound("data/audio/Desktop/misc.bank", "misc/beam_from_sky_kick", x, y)
                GamePrintImportant("SOUL SEPARATED!", "You are now a soulless being.", "mods/souls/files/souls_decoration.png")
                EntityAddComponent2(player, "LuaComponent", {
                    script_source_file="mods/souls/files/scripts/player_souls_count_check.lua",
                    execute_every_n_frame=2,
                })
                return 0, 0
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
        if GameHasFlagRun("souls_phylactery_done") then
            local phylactery_points = tonumber(GlobalsGetValue("souls_phylactery_points", "0"))
            --[[if tonumber(GlobalsGetValue("souls_phylactery_points_used", "0")) == 250 then
                EntityAddTag(player, "souls_lich")
            end]]
            if  phylactery_points > 0 then
                GlobalsSetValue("souls_phylactery_points", tostring(phylactery_points - 1))
                GlobalsSetValue("souls_phylactery_points_used", tostring(tonumber(GlobalsGetValue("souls_phylactery_points_used")) + 1))
                return 0, 0
            elseif phylactery_points <= 0 then
                return damage, critical_hit_chance
            end
        end
    end
    return damage, critical_hit_chance
end