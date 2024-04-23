dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local entity_id = GetUpdatedEntityID()
local root_id = EntityGetRootEntity( entity_id )
local x, y = EntityGetTransform( entity_id )

local mark_radius = 50

local targets = EntityGetInRadiusWithTag( x, y, mark_radius, "homing_target" )

if ( #targets > 0 ) then
    for i,target_id in ipairs( targets ) do

        if ( EntityHasTag( target_id, "tome_reap_marked" ) == false ) then

            EntityAddComponent( target_id, "LuaComponent",
            {
                script_death = "mods/tales_of_kupoli/files/entities/misc/tome_reap_death.lua",
                execute_every_n_frame = "-1",
            } )

            EntityAddTag( target_id, "tome_reap_marked")
        end
    end
end