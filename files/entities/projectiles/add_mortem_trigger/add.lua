dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local entity_id = GetUpdatedEntityID()
local root_id = EntityGetRootEntity( entity_id )
local x, y = EntityGetTransform( entity_id )

local mark_radius = 42

local targets = EntityGetInRadiusWithTag( x, y, mark_radius, "homing_target" )

if ( #targets > 0 ) then
    for i,target_id in ipairs( targets ) do

        local tocast = ""

        local vscs = EntityGetAllComponents(entity_id)

        for i,v in ipairs(vscs) do
            if ComponentGetTypeName(v) == "VariableStorageComponent" then
                if ComponentGetValue2(v, "name") == "projectile_file" then
                    tocast = ComponentGetValue2(v, "value_string")
                end
            end
        end

        if ( EntityHasTag( target_id, "mortem_trigger_added" ) == false ) then

            EntityAddComponent( target_id, "LuaComponent",
            {
                script_death="mods/tales_of_kupoli/files/entities/projectiles/add_mortem_trigger/death.lua",
                execute_every_n_frame="-1",
            } )

            EntityAddComponent( target_id, "VariableStorageComponent", {
                _tags="kupoli_mortem_trigger",
                name="kupoli_mortem_trigger",
                value_string=tocast,
                
            } )

            EntityAddTag( target_id, "mortem_trigger_added")
        end
    end
end