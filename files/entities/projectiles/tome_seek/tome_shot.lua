dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local entity_id = GetUpdatedEntityID()
local root_id = EntityGetRootEntity( entity_id )
local x, y = EntityGetTransform( entity_id )

math.randomseed(x,y+GameGetFrameNum())

local mark_radius = 60

local targets = EntityGetInRadiusWithTag( x, y, mark_radius, "homing_target" )

if ( #targets > 0 ) then
    for i,target_id in ipairs( targets ) do
        if math.random(1,1) == 1 then
            if ( EntityHasTag( target_id, "reap_marked" ) == false ) then

                EntityAddComponent( target_id, "LuaComponent", {
                    script_death = "mods/tales_of_kupoli/files/scripts/reap.lua",
                    execute_every_n_frame = "-1",
                } )

                EntityAddComponent( target_id, "LightComponent", {
                    radius = "100",
                    r = "100",
                    g = "255",
                    b = "255",
                } )
    
                EntityAddTag( target_id, "reap_marked")
            end
    
            if EntityHasTag(target_id, "reap_marked_fx") == false then
                local effect_id = EntityLoad("mods/tales_of_kupoli/files/entities/particles/marked_particles.xml", x, y)
                EntityAddChild(target_id, effect_id)
                EntityAddTag(target_id, "reap_marked_fx")
            end
        end
    end
end