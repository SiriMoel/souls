function shot(proj)
    local comp_proj = EntityGetFirstComponent(proj, "ProjectileComponent")
    if comp_proj ~= nil then
        local damage = ComponentGetValue2(comp_proj, "damage")
        if damage > 0 then
            damage = damage * 0.6
            ComponentSetValue2(comp_proj, "damage", damage)
        end
    end
end