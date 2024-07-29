dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

function collision_trigger(colliding_entity_id)
    if not EntityHasTag(colliding_entity_id, "soul_slice_hit") then
        AddSoul("friendly")
        EntityAddTag(colliding_entity_id, "soul_slice_hit")
        GamePrint("Hit!")
    end
end