local this = GetUpdatedEntityID()

local x, y = EntityGetTransform(this)

local comp_mode = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "mode")
local mode = ComponentGetValue2(comp_mode, "value_string")

local frame_now = GameGetFrameNum()

local comp_soul = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "soul")
local soul = ComponentGetValue2(comp_soul, "value_float")

if mode == "connect" then
    y = y + 2

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
                t_y = t_y + 2
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

                        local rand = Random(-beam_range, beam_range)
                        local particles_x = beam_x + rand * math.cos(a)
                        local particles_y = beam_y + rand * math.sin(a)
                        local vel_x = 2 * beam_range * math.cos(a)
                        local vel_y = 3 * beam_range * math.sin(a)

                        local damage_targets = EntityGetInRadiusWithTag(beam_x, beam_y, beam_range, "enemy") or {}
                        if #damage_targets > 0 then
                            for ii = 1, #damage_targets do
                                soul = soul - 0.013
                                local target = damage_targets[ii]
                                local reapers = EntityGetAllChildren(target, "souls_reaper_sentinel") or {}
                                if #reapers == 0 then
                                    EntityAddChild(target, EntityLoad("mods/souls/files/entities/misc/reapers/reap_entity_sentinel.xml", beam_x, beam_y))
                                end
                                EntityInflictDamage(target, 0.14, "DAMAGE_SLICE", "", "DISINTEGRATED", 0, 0, this, beam_x, beam_y, 0)
                                EntityLoad("mods/souls/files/entities/misc/soul_blood_fx.xml", beam_x + Random(-6, 6), beam_y + Random(-6, 6))
                                GamePlaySound("data/audio/Desktop/projectiles.bank", "player_projectiles/fizzle/create", beam_x, beam_y)
                            end
                        end
                    end
                end
            end
        end
    end
end

if soul <= 0 then
    EntityKill(this)
end
ComponentSetValue2(comp_soul, "value_float", soul)