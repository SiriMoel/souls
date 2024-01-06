dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
    local entity = GetUpdatedEntityID()

    local x, y = EntityGetTransform(entity)

    SetRandomSeed(x, y)    
math.randomseed(x, y+GameGetFrameNum())

    local comp_tocast = EntityGetFirstComponentIncludingDisabled(entity, "VariableStorageComponent", "kupoli_mortem_trigger") or 0

    local proj = shoot_projectile(GetPlayer(), ComponentGetValue2(comp_tocast, "value_string"), x, y, 0, 0)
    EntityAddComponent2(proj, "HomingComponent", {
        target_tag="homing_target",
		homing_targeting_coeff=6,
		detect_distance=150,
		homing_velocity_multiplier=2,
    })
end