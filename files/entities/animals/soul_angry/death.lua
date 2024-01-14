dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
    local entity = GetUpdatedEntityID()
    local x, y = EntityGetTransform(entity)

    math.randomseed(x, y+GameGetFrameNum())

    for i=1,3 do
        AddSoul("gilded")
    end

    if math.random(1,10) == 2 then
        CreateItemActionEntity( "KUPOLI_EAT_WAND_FOR_SOULS", x, y )
    end
end