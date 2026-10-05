dofile_once("mods/souls/files/scripts/souls.lua")

function damage_about_to_be_received(damage, x, y, entity_thats_responsible, critical_hit_chance)
    local player = GetUpdatedEntityID()
    if damage > 0 then        
        local comp_damagemodel = EntityGetFirstComponentIncludingDisabled(player, "DamageModelComponent")
        local max_hp = ComponentGetValue2(comp_damagemodel, "max_hp")
        if damage >= max_hp then
            EntityLoad("mods/souls/files/entities/misc/expelled_soul/thing.xml", x, y)
            GamePlaySound("data/audio/Desktop/misc.bank", "misc/chest_dark_open", x, y)
            GamePlaySound("data/audio/Desktop/misc.bank", "misc/beam_from_sky_kick", x, y)
            SoulsPrintImportant("SOUL SEPARATED!", "You are a soulless being.")
            local diviner = EntityGetAllChildren(player, "souls_diviner")[1]
            local comp_state = EntityGetFirstComponentIncludingDisabled(diviner, "VariableStorageComponent", "state")
            ComponentSetValue2(comp_state, "value_int", 2)
            local this_comp = GetUpdatedComponentID()
            EntityRemoveComponent(player, this_comp)
            return 0, 0
        end
    end
    return damage, critical_hit_chance
end