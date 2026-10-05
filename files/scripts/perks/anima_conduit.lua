function on_reap(player, n)
    local comp = EntityGetFirstComponentIncludingDisabled(player, "DamageModelComponent")
    if comp ~= nil then
        local hp = ComponentGetValue2(comp, "hp")
        local max_hp = ComponentGetValue2(comp, "max_hp")
        hp = hp + 0.005 * max_hp * n -- 0.5% per soul
        if hp > max_hp then
            hp = max_hp
        end
        ComponentSetValue2(comp, "hp", hp)
    end
end
return {on_reap = on_reap}