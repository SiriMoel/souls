dofile_once("mods/souls/files/scripts/souls.lua")

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
    local entity = GetUpdatedEntityID()
    local soul = GetEntitySoulType(entity)
    DontFearTheReaper({[soul] = 2}, entity)
end