dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local entity_id = GetUpdatedEntityID()
local root_id = EntityGetRootEntity( entity_id )
local x, y = EntityGetTransform( entity_id )

local mark_radius = 56

local targets = EntityGetInRadiusWithTag( x, y, mark_radius, "homing_target" )

if #targets > 0 then
    for i,target_id in ipairs( targets ) do
        if EntityHasTag( target_id, "weak_marked" ) == false then
            local comps_damagemodel = EntityGetComponentIncludingDisabled(entity, "DamageModelComponent") or {}
            for i,comp in ipairs(comps_damagemodel) do
                ComponentObjectSetValue2(comp, "damage_multipliers", "projectile", (ComponentObjectGetValue2(comp, "damage_multipliers", "projectile") or 1) + 0.3)
                ComponentObjectSetValue2(comp, "damage_multipliers", "slice", (ComponentObjectGetValue2(comp, "damage_multipliers", "slice") or 1) + 0.3)
                ComponentObjectSetValue2(comp, "damage_multipliers", "melee", (ComponentObjectGetValue2(comp, "damage_multipliers", "melee") or 1) + 0.3)
                ComponentObjectSetValue2(comp, "damage_multipliers", "melee", (ComponentObjectGetValue2(comp, "damage_multipliers", "explosion") or 1) + 0.3)
                ComponentObjectSetValue2(comp, "damage_multipliers", "fire", (ComponentObjectGetValue2(comp, "damage_multipliers", "fire") or 1) + 0.3)
                ComponentObjectSetValue2(comp, "damage_multipliers", "ice", (ComponentObjectGetValue2(comp, "damage_multipliers", "ice") or 1) + 0.3)
                ComponentObjectSetValue2(comp, "damage_multipliers", "electricity", (ComponentObjectGetValue2(comp, "damage_multipliers", "electricity") or 1) + 0.3)
            end
            EntityAddTag( target_id, "weak_marked")
        end
    end
end