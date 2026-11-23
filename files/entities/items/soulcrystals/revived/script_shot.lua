function shot(proj)
    local comp_proj = EntityGetFirstComponent(proj, "ProjectileComponent")
    if comp_proj ~= nil then
        local damage = ComponentGetValue2(comp_proj, "damage")
        if damage > 0 then
            damage = damage * 1.2
            ComponentSetValue2(comp_proj, "damage", damage)
        end
    end
    local comp_part = EntityGetFirstComponent(proj, "ParticleEmitterComponent")
    if comp_part ~= nil then
        ComponentSetValue2(comp_part, "emitted_material_name", "souls_living_particles")
    end
end