function damage_received(damage, message, entity_thats_responsible, is_fatal, projectile_thats_responsible)
    local this = GetUpdatedEntityID()
    if projectile_thats_responsible ~= nil and damage > 0 then
        if EntityHasTag(projectile_thats_responsible, "soul_projectile") then
            local effects = EntityGetAllChildren(this, "souls_effect_focus") or {}
            if #effects > 0 then
                local effect = effects[1]
                local comp_amt = EntityGetFirstComponentIncludingDisabled(effect, "VariableStorageComponent", "souls_focus")
                if comp_amt ~= nil then
                    local amt = ComponentGetValue2(comp_amt, "value_float")
                    amt = math.min(amt + 0.2, 2)
                    ComponentSetValue2(comp_amt, "value_float", amt)
                    local comp_ge = EntityGetFirstComponentIncludingDisabled(effect, "GameEffectComponent")
                    if comp_ge ~= nil then
                        local frames = ComponentGetValue2(comp_ge, "frames")
                        frames = math.min(frames + 40, 400)
                        ComponentSetValue2(comp_ge, "frames", frames)
                    end
                end
            end
        end
    end
end