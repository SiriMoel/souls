dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local entity_id = GetUpdatedEntityID()
local root_id = EntityGetRootEntity( entity_id )
local x, y = EntityGetTransform( entity_id )

local mark_radius = 56

local targets = EntityGetInRadiusWithTag( x, y, mark_radius, "homing_target" )

if #targets > 0 then
    for i,target_id in ipairs( targets ) do
        if EntityHasTag( target_id, "weak_marked" ) == false then
            local names = { "projectile", "explosion", "melee", "electricity" }
            for i=1,#names do
                local comp = EntityGetFirstComponent( target_id, "DamageModelComponent" ) or 0
                local mult = ComponentObjectGetValue2( comp, "damage_multipliers", name )
		        mult = mult + 0.2
    		    ComponentObjectSetValue2( comp, "damage_multipliers", name, mult )
            end
            EntityAddTag( target_id, "weak_marked")
        end
    end
end