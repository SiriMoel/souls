dofile_once("mods/souls/files/scripts/souls.lua")

function damage_about_to_be_received(damage, x, y, entity_thats_responsible, critical_hit_chance)
    local player = GetUpdatedEntityID()

    if damage > 0 then
        local anima_conduit = EntityGetFirstComponentIncludingDisabled(player, "LuaComponent", "souls_anima_conduit")
        if anima_conduit ~= nil then
            damage = damage * 1.25
        end

        if GameHasFlagRun("souls_cursed") then
            damage = damage * 1.4
        end
    end

    local held_item = HeldItem(player)
    local inv_items = GameGetAllInventoryItems(player) or {}
    if #inv_items > 0 then
        for _, item in ipairs(inv_items) do
            local comps = EntityGetComponentIncludingDisabled(item, "LuaComponent", "souls_player_damage") or {}
            if #comps > 0 then
                for i = 1, #comps do
                    local comp = comps[i]
                    local script = ComponentGetValue2(comp, "script_source_file")
                    local is_held = false
                    if item == held_item then
                        is_held = true
                    end
                    local funcs = dofile_once(script)
                    if funcs.player_damage ~= nil then
                        damage, critical_hit_chance = funcs.player_damage(item, player, damage, critical_hit_chance, is_held)
                    end
                end
            end
        end
    end
    return damage, critical_hit_chance
end

function damage_received(damage, message, entity_thats_responsible, is_fatal, projectile_thats_responsible)
    local player = GetUpdatedEntityID()

    if damage > 0 then
        if GameHasFlagRun("souls_cursed") then
            local souls_lost = math.floor(damage / 0.2) -- 5 damage = 1 soul lost
            LoseSouls(player, souls_lost, false)
        end
    end

    local held_item = HeldItem(player)
    local inv_items = GameGetAllInventoryItems(player) or {}
    if #inv_items > 0 then
        for _, item in ipairs(inv_items) do
            local comps = EntityGetComponentIncludingDisabled(item, "LuaComponent", "souls_player_damage") or {}
            if #comps > 0 then
                for i = 1, #comps do
                    local comp = comps[i]
                    local script = ComponentGetValue2(comp, "script_source_file")
                    local is_held = false
                    if item == held_item then
                        is_held = true
                    end
                    local funcs = dofile_once(script)
                    if funcs.player_damaged ~= nil then
                        funcs.player_damaged(item, player, damage, message, entity_thats_responsible, is_fatal, projectile_thats_responsible, is_held)
                    end
                end
            end
        end
    end
end