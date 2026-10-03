dofile_once("mods/souls/files/scripts/souls.lua")

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
    local entity = GetUpdatedEntityID()
    local x, y = EntityGetTransform(entity)
    SetRandomSeed(x, y)
    local souls = {}
    for i = 1, 5 do
        local which = soul_types[Random(1, #soul_types - 2)]
        souls[which] = (souls[which] or 0) + 1
    end
    DontFearTheReaper(souls, entity)
end