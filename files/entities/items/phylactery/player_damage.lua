function player_damage(item, player, damage, critical_hit_chance, is_held)
    if damage > 0 then
        local comp_p = EntityGetFirstComponentIncludingDisabled(item, "VariableStorageComponent", "phylactery")
        if comp_p ~= nil then
            local p = ComponentGetValue2(comp_p, "value_int")
            if p > 0 then
                local comp_dmg = EntityGetFirstComponent(player, "DamageModelComponent")
                local hp = ComponentGetValue2(comp_dmg, "hp")
                if damage >= hp then
                    local comp_p_frame = EntityGetFirstComponentIncludingDisabled(item, "VariableStorageComponent", "phyl_frame")
                    if comp_p_frame ~= nil then
                        local p_frame = ComponentGetValue2(comp_p_frame, "value_int")
                        local frame_now = GameGetFrameNum()
                        if frame_now >= p_frame then
                            ComponentSetValue2(comp_p, "value_int", p - 1)
                            ComponentSetValue2(comp_p_frame, "value_int", frame_now + 12)
                            local x, y = EntityGetTransform(player)
                            GamePlaySound("data/audio/Desktop/projectiles.bank", "projectiles/enlightened_laser/launch_dark", x, y)
                        end
                    end
                    return 0, 0
                end
            end
        end
    end
    return damage, critical_hit_chance
end
function player_damaged(item, player, damage, message, entity_thats_responsible, is_fatal, projectile_thats_responsible, is_held)
    if damage > 0 then
        local comp_p = EntityGetFirstComponentIncludingDisabled(item, "VariableStorageComponent", "phylactery")
        if comp_p ~= nil then
            local p = ComponentGetValue2(comp_p, "value_int")
            if p > 0 then
                local comp_p_frame = EntityGetFirstComponentIncludingDisabled(item, "VariableStorageComponent", "phyl_frame")
                if comp_p_frame ~= nil then
                    local p_frame = ComponentGetValue2(comp_p_frame, "value_int")
                    local frame_now = GameGetFrameNum()
                    if frame_now >= p_frame then
                        ComponentSetValue2(comp_p, "value_int", p - 1)
                        ComponentSetValue2(comp_p_frame, "value_int", frame_now + 12)
                        local x, y = EntityGetTransform(player)
                        GamePlaySound("data/audio/Desktop/projectiles.bank", "projectiles/enlightened_laser/launch_dark", x, y)
                    end
                end
                local comp_dmg = EntityGetFirstComponent(player, "DamageModelComponent")
                local hp = ComponentGetValue2(comp_dmg, "hp")
                ComponentSetValue2(comp_dmg, "hp", hp + damage)
            end
        end
    end
end
return {player_damage = player_damage, player_damaged = player_damaged}