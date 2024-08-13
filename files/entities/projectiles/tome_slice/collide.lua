dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")

function collision_trigger(colliding_entity_id)
    if not EntityHasTag(colliding_entity_id, "soul_slice_hit") then
        AddSouls("friendly", 1)
        EntityAddTag(colliding_entity_id, "soul_slice_hit")
        GamePrint("Hit!")
    end
end