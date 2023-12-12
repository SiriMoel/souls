dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local entity_id = GetUpdatedEntityID()
local root_id = EntityGetRootEntity( entity_id )
local x, y = EntityGetTransform( entity_id )

local mark_radius = 80

local targets = EntityGetInRadiusWithTag( x, y, mark_radius, "homing_target" )

if ( #targets > 0 ) then
    for i,target_id in ipairs( targets ) do

        if EntityGetName(target_id) == "$animal_worm_big" then
            if ( EntityHasTag( target_id, "kupoli_worm_enhanced" ) == false ) then

                EntityAddComponent( target_id, "LuaComponent",
                {
                    script_death = "mods/tales_of_kupoli/files/entities/projectiles/worm_enhancer/enhanced_death.lua",
                    execute_every_n_frame = "-1",
                } )
    
                local effect_id = EntityLoad("mods/tales_of_kupoli/files/entities/projectiles/worm_enhancer/enhanced_particles.xml", x, y)
                EntityAddChild( target_id, effect_id )
    
                EntityAddTag( target_id, "kupoli_worm_enhanced")
            end
        end
    end
end