dofile_once("mods/souls/files/scripts/souls.lua")

local death_old = death

function death(damage_type_bit_field, damage_message, entity_thats_responsible, ...)
    local this = GetUpdatedEntityID()
    local x, y = EntityGetTransform(this)
    SetRandomSeed(x, y + this)
    local soul_count = 0
    if Random(1, 4) == 1 then
        soul_count = soul_count + 1
    end
    if EntityHasTag(entity_thats_responsible, "player_unit") then
        local comp_reap_better = EntityGetFirstComponentIncludingDisabled(entity_thats_responsible, "VariableStorageComponent", "souls_reap_better")
        if comp_reap_better ~= nil then
            soul_count = soul_count + ComponentGetValue2(comp_reap_better, "value_int")
        end
    end
    if soul_count > 0 then
        local souls = {}
        local soul_type = GetEntitySoulType(this)
        souls[soul_type] = soul_count
        DontFearTheReaper(souls, this)
    end
    death_old(damage_type_bit_field, damage_message, entity_thats_responsible, ...)
end