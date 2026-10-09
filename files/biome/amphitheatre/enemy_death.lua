dofile_once("mods/souls/files/scripts/souls.lua")

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
    local entity = GetUpdatedEntityID()
    local souls = {}
    local soul = GetEntitySoulType(entity)
    souls[soul] = 2
    local x, y = EntityGetTransform(entity)
    SetRandomSeed(x, y + entity)
    if Random(1, 5) == 1 then
        souls["souls_void"] = (souls["souls_void"] or 0) + 1
    end
    DontFearTheReaper(souls, entity)
end