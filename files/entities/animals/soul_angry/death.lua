dofile_once("mods/souls/files/scripts/souls.lua")

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
    local entity = GetUpdatedEntityID()
    local x, y = EntityGetTransform(entity)
    SetRandomSeed(x, y)
    DontFearTheReaper({["souls_void"] = 1}, entity)
    if Random(1, 6) == 2 then
        CreateItemActionEntity("SOULS_EAT_WAND_FOR_SOULS", x, y - 2)
    end
end