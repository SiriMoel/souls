local effect = GetUpdatedEntityID()
local comp_amt = EntityGetFirstComponentIncludingDisabled(effect, "VariableStorageComponent", "souls_focus")
if comp_amt ~= nil then
    local specs = EntityGetComponent(effect, "SpriteParticleEmitterComponent") or {}
    if #specs > 0 then
        local amt = ComponentGetValue2(comp_amt, "value_float")
        amt = amt - 0.005
        if amt <= 0 then
            EntityKill(effect)
        else
            ComponentSetValue2(comp_amt, "value_float", amt)
            for i=1,#specs do
                local spec = specs[i]
                --local frame = GameGetFrameNum()
                --local scale_x = math.sin(math.pi * frame / 15)
                local scale_y = 0.2 + amt
                ComponentSetValue2(spec, "scale", scale_y, scale_y)
                local rot = ComponentGetValue2(spec, "rotation")
                rot = rot + 0.052
                ComponentSetValue2(spec, "rotation", rot)
            end
            local comp_p = EntityGetFirstComponentIncludingDisabled(effect, "ParticleEmitterComponent")
            if comp_p ~= nil then
                ComponentSetValue2(comp_p, "count_max", math.ceil((amt / 0.2) * 3))
                ComponentSetValue2(comp_p, "area_circle_radius", 0, 16 * amt)
            end
        end
    end
end