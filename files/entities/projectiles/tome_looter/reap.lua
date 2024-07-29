dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
    local entity = GetUpdatedEntityID()
    local herd_id_number = ComponentGetValue2( EntityGetFirstComponent( entity, "GenomeDataComponent" ) or 0, "herd_id")
    local herd_id = HerdIdToString(herd_id_number)
    local x, y = EntityGetTransform(entity)

    if not table.contains(soul_types, herd_id) then return end

    SetRandomSeed(x, y)
    math.randomseed(x, y+GameGetFrameNum())

    local dodrop = math.random(1,30)

    if dodrop == 2 then
        local which = math.random(1,2)
        if which == 1 then
            GamePrint("Chest dropped!")
            EntityLoad("mods/souls/files/entities/items/soulchest/chest.xml", x, y)
        end
        if which == 2 then
            GamePrint("Key dropped!")
            EntityLoad("mods/souls/files/entities/items/soulchest/key/key.xml", x, y)
        end
    end
end