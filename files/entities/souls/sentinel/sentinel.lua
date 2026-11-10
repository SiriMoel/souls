local this = GetUpdatedEntityID()

local x, y = EntityGetTransform(this)

local comp_mode = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "mode")
local mode = ComponentGetValue2(comp_mode, "value_string")

local frame_now = GameGetFrameNum()

local comp_soul = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "soul")
local soul = ComponentGetValue2(comp_soul, "value_float")

local comp_eyes = EntityGetFirstComponent(this, "SpriteComponent", "eyes")

local function eyes(look_x, look_y)
    local eyes_offset_x = 0
    local eyes_offset_y = 0
    local dist_x = x - look_x
    local dist_y = y - look_y
    local a = math.atan2(dist_y, dist_x)
    eyes_offset_x = eyes_offset_x + math.cos(a) * -1.3
    eyes_offset_y = eyes_offset_y + math.sin(a) * -1.3
    ComponentSetValue2(comp_eyes, "transform_offset", eyes_offset_x, eyes_offset_y)
end

local comp_attack_frame = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "attack_frame")
local attack_frame = ComponentGetValue2(comp_attack_frame, "value_int")

local function attack_target(range)
    local attack_entity
    local targets = EntityGetInRadiusWithTag(x, y, range, "mortal") or {}
    if #targets > 0 then
        for i = 1, #targets do
            local target = targets[i]
            local t_x, t_y = EntityGetTransform(target)
            if not RaytraceSurfaces(x, y, t_x, t_y - 2) then
                if EntityGetHerdRelationSafe(this, target) < 100 then
                    attack_entity = target
                    break
                end
            end
        end
    end
    return attack_entity
end

local function shoot_projectile(who_shot, entity_file, x, y, vel_x, vel_y, send_message)
	local projectile = EntityLoad(entity_file, x, y)
	local herd_id = StringToHerdId("player")
	if send_message == nil then send_message = true end
	GameShootProjectile(who_shot, x, y, x+vel_x, y+vel_y, projectile, send_message)
    local comp_proj = EntityGetFirstComponent(projectile, "ProjectileComponent")
    ComponentSetValue2(comp_proj, "mWhoShot", who_shot)
    ComponentSetValue2(comp_proj, "mShooterHerdId", herd_id)
    local comp_vel = EntityGetFirstComponent(projectile, "VelocityComponent")
    ComponentSetValueVector2(comp_vel, "mVelocity", vel_x, vel_y)
	return projectile
end

if mode == "melee" then
    if frame_now > attack_frame then
        local target = attack_target(45)
        if target ~= nil then
            GamePlayAnimation(this, "melee_attack", 11, "melee_ready", 10)
            ComponentSetValue2(comp_attack_frame, "value_int", frame_now + 100)
            local t_x, t_y = EntityGetTransform(target)
            local reapers = EntityGetAllChildren(target, "souls_reaper_sentinel") or {}
            if #reapers == 0 then
                EntityAddChild(target, EntityLoad("mods/souls/files/entities/misc/reapers/reap_entity_sentinel.xml", t_x, t_y))
            end
            EntityInflictDamage(target, 8, "DAMAGE_SLICE", "", "DISINTEGRATED", 0, 0, this, x, y, 10)
            soul = soul - 0.2
            eyes(t_x, t_y - 4)
        end
    end
end

if mode == "projectile" then
    if frame_now > attack_frame then
        local target = attack_target(240)
        if target ~= nil then
            GamePlayAnimation(this, "projectile_attack", 11, "projectile", 10)
            ComponentSetValue2(comp_attack_frame, "value_int", frame_now + 40)
            local t_x, t_y = EntityGetTransform(target)
            t_y = t_y - 2
            local vel = 300
            local a = math.atan2(t_y - y, t_x - x)
            local vel_x = vel * math.cos(a)
            local vel_y = vel * math.sin(a)
            shoot_projectile(this, "mods/souls/files/entities/souls/sentinel/projectile.xml", x, y, vel_x, vel_y)
            soul = soul - 0.05
            eyes(t_x, t_y - 2)
        end
    end
end

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
                    if beams == 0 then eyes(t_x, t_y - 10) end
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

if mode == "follow" then
    local targets = EntityGetInRadiusWithTag(x, y, 300, "player_unit") or {}
    if #targets > 0 then
        local target = targets[1]
        local t_x, t_y = EntityGetTransform(target)
        eyes(t_x, t_y - 5)
    end
end

if soul <= 0 then
    EntityKill(this)
end
ComponentSetValue2(comp_soul, "value_float", soul)