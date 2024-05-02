dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local entity_id = GetUpdatedEntityID()
local root_id = EntityGetRootEntity( entity_id )
local x, y = EntityGetTransform( entity_id )

local mark_radius = 56

local targets = EntityGetInRadiusWithTag( x, y, mark_radius, "homing_target" )

if ( #targets > 0 ) then
    for i,target_id in ipairs( targets ) do

        if ( EntityHasTag( target_id, "weak_marked" ) == false ) then
            local comps_damagemodel = EntityGetComponentIncludingDisabled(entity, "DamageModelComponent") or {}

            for i,comp in ipairs(comps_damagemodel) do
                local members = ComponentObjectGetMembers(comp, "damage_multipliers") or {}
                for i,multiplier in ipairs(members) do
                    -- does this work?
                    ComponentObjectSetValue2(comp, "damage_multipliers", multiplier, ComponentObjectGetValue2(comp, "damage_multipliers", multiplier) * 1.3)
                end
            end

            EntityAddTag( target_id, "weak_marked")
        end
    end
end