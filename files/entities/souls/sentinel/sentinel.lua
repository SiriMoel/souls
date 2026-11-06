local this = GetUpdatedEntityID()

local x, y = EntityGetTransform(this)

local comp_mode = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "mode")
local mode = ComponentGetValue2(comp_mode, "value_string")

--[[if mode == "melee" then

end]]

--[[if mode == "projectile" then

end]]

if mode == "connect" then
    local max_beams = 2
    local beams = 0
    local beam_steps = 5

    local targets = EntityGetInRadiusWithTag(x, y, 180, "souls_sentinel") or {}
    if #targets > 0 then
        for _, target in ipairs(targets) do
            local target_comp_mode = EntityGetFirstComponentIncludingDisabled(target, "VariableStorageComponent", "mode")
            local target_mode = ComponentGetValue2(target_comp_mode, "value_string")
            if target_mode == "connect" and beams < max_beams then
                local t_x, t_y = EntityGetTransform(target)
                local dist_y = t_y - y
                local dist_x = t_x - x
                local dist_xy = math.sqrt(dist_y*dist_y + dist_x*dist_x)

                if dist_xy > 25 then
                    beams = beams + 1
                    local a = math.atan2(dist_y, dist_x)
                    for i = 1, beam_steps do
                        local beam_x = x + (dist_xy / (beam_steps + 1)) * i * math.cos(a)
                        local beam_y = y + (dist_xy / (beam_steps + 1)) * i * math.sin(a)

                        local beam_range = (dist_xy / beam_steps * 0.5)

                        local particles_x = beam_x + Random(-beam_range, beam_range) * math.cos(a)
                        local particles_y = beam_y + Random(-beam_range, beam_range) * math.sin(a)
                        local vel_x = 2 * beam_range * math.cos(a)
                        local vel_y = 3 * beam_range * math.sin(a)
                        GameCreateCosmeticParticle("souls_soul_particles", particles_x - 0.5 * beam_range * math.cos(a), particles_y - 0.5 * beam_range * math.sin(a), 1, Random(-vel_x, vel_x), Random(-vel_y, vel_y), nil, 0.2, 0.4, true, false, true, true, 0, 0)
                        GameCreateCosmeticParticle("souls_soul_particles", particles_x + 0.5 * beam_range * math.cos(a), particles_y + 0.5 * beam_range * math.sin(a), 1, Random(-vel_x, vel_x), Random(-vel_y, vel_y), nil, 0.2, 0.4, true, false, true, true, 0, 0)
                        local damage_targets = EntityGetInRadiusWithTag(beam_x, beam_y, beam_range, "enemy") or {}
                        if #damage_targets > 0 then
                            for ii = 1, #damage_targets do
                                EntityInflictDamage(damage_targets[ii], 0.01, "DAMAGE_SLICE", "", "DISINTEGRATED", 0, 0, this, beam_x, beam_y, 0)
                            end
                        end
                        --[[local damage_targets_player = EntityGetInRadiusWithTag(beam_x, beam_y, beam_range, "player_unit") or {}
                        if #damage_targets_player > 0 then
                            for ii = 1, #damage_targets_player do
                                EntityInflictDamage(damage_targets_player[ii], 0.005, "DAMAGE_CURSE", "", "DISINTEGRATED", 0, 0, this, beam_x, beam_y, 0)
                            end
                        end]]
                    end
                end
            end
        end
    end
end

--[[if mode == "follow" then

end]]