function player_damage(item, player, damage, critical_hit_chance, is_held)
    if damage > 0 then
        local comp = EntityGetFirstComponentIncludingDisabled(item, "VariableStorageComponent", "soulward_stored")
        local stored_damage = ComponentGetValue2(comp, "value_float")
        if is_held then
            stored_damage = stored_damage + 0.75 * damage
            damage = damage * 0.25
            critical_hit_chance = 0
            ComponentSetValue2(comp, "value_float", stored_damage)
        elseif stored_damage > 0 then
            local amt = math.min(damage, stored_damage)
            damage = damage - amt
            stored_damage = stored_damage - amt
            ComponentSetValue2(comp, "value_float", stored_damage)
        end
    end
    return damage, critical_hit_chance
end
return {player_damage = player_damage}