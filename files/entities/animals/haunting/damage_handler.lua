function damage_about_to_be_received(damage, x, y, entity_thats_responsible, critical_hit_chance)
    if damage > 0 then
        local this = GetUpdatedEntityID()
        local comp_damagemodel = EntityGetFirstComponentIncludingDisabled(this, "DamageModelComponent")
        local max_hp = ComponentGetValue2(comp_damagemodel, "max_hp")
        if damage > max_hp * 0.08 then
            damage = max_hp * 0.08 + (damage - max_hp * 0.08) * 0.2
        end
    end
    critical_hit_chance = 0
    return damage, critical_hit_chance
end

--[[function damage_received(damage, message, entity_thats_responsible, is_fatal, projectile_thats_responsible)
    local this = GetUpdatedEntityID()
    if projectile_thats_responsible ~= nil then
        local comp_damagemodel = EntityGetFirstComponentIncludingDisabled(this, "DamageModelComponent")
        local max_hp = ComponentGetValue2(comp_damagemodel, "max_hp")
        if damage >= max_hp * 0.1 then
            EntityKill(projectile_thats_responsible) 
            -- do I need to EntityGetIsAlive() ?
            -- maybe set lifetime to 1 instead of EntityKill() ?
        end
    end
end]]