function damage_about_to_be_received(damage, x, y, entity_thats_responsible, critical_hit_chance)
    local effect = GetUpdatedEntityID()
    if damage > 0 then
        local comp_amt = EntityGetFirstComponentIncludingDisabled(effect, "VariableStorageComponent", "souls_focus")
        if comp_amt ~= nil then
            local amt = ComponentGetValue2(comp_amt, "value_float")
            damage = damage * (1 + amt)
        end
    end
    local root = EntityGetRootEntity(effect)
    local comp_damaged = EntityGetFirstComponent(root, "LuaComponent", "soul_focus_damaged") or EntityAddComponent2(root, "LuaComponent", {
        _tags="soul_focus_damaged",
        script_damage_received="mods/souls/files/entities/projectiles/soul_focus/damaged.lua"
    })
    return damage, critical_hit_chance
end