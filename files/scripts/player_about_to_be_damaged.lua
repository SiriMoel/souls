dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

function damage_about_to_be_received(damage, x, y, entity_thats_responsible, critical_hit_chance )
    local player = GetUpdatedEntityID()

    local helditem = HeldItem(player)
    if EntityHasTag(helditem, "kupoli_deadringer") then
        local comp_cd = EntityGetFirstComponentIncludingDisabled(helditem, "VariableStorageComponent", "deadringer_cd") or 0
        local cd = ComponentGetValue2(comp_cd, "value_int")
        if cd <= 0 then
            if GetSoulsCount("all") >= 10 then
                RemoveSouls(10)
                local effects_to_remove = { "WET", "OILY", "BLOODY", "RADIOACTIVE", "ON_FIRE" }
                for i,v in ipairs(effects_to_remove) do
                    EntityRemoveStainStatusEffect(player, v)
                end
                LoadGameEffectEntityTo(player, "mods/souls/files/entities/items/deadringer/buff.xml")
                ComponentSetValue2(comp_cd, "value_int", 600)
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

    if GameHasFlagRun("kupoli_phylactery_done") then
        local phylactery_points = tonumber(GlobalsGetValue("kupoli_phylactery_points", "0"))

        if tonumber(GlobalsGetValue("kupoli_phylactery_points_used", "0")) == 250 then
            EntityAddTag(player, "kupoli_lich")
        end
    
        if  phylactery_points > 0 then
            GlobalsSetValue("kupoli_phylactery_points", tostring(phylactery_points - 1))
            GlobalsSetValue("kupoli_phylactery_points_used", tostring(tonumber(GlobalsGetValue("kupoli_phylactery_points_used")) + 1))
            return 0, 0
        elseif phylactery_points <= 0 then
            return damage * 1.5, critical_hit_chance
        end
    end

    return damage, critical_hit_chance
end