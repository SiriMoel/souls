local function shoot_projectile(who_shot, entity_file, x, y, vel_x, vel_y, send_message)
	local projectile = EntityLoad(entity_file, x, y)
	local herd_id = StringToHerdId("souls_void")
	if send_message == nil then send_message = true end
	GameShootProjectile(who_shot, x, y, x+vel_x, y+vel_y, projectile, send_message)
    local comp_proj = EntityGetFirstComponent(projectile, "ProjectileComponent")
    ComponentSetValue2(comp_proj, "mWhoShot", who_shot)
    ComponentSetValue2(comp_proj, "mShooterHerdId", herd_id)
    local comp_vel = EntityGetFirstComponent(projectile, "VelocityComponent")
    ComponentSetValueVector2(comp_vel, "mVelocity", vel_x, vel_y)
	return projectile
end
local this = GetUpdatedEntityID()
local comp_level = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "haunting_level")
local level = ComponentGetValue2(comp_level, "value_int")
local x, y = EntityGetTransform(this)
local targets = EntityGetInRadiusWithTag(x, y, 500, "player_unit") or {}
if #targets > 0 then
    local frame_now = GameGetFrameNum()
    local player = targets[1]
    local px, py = EntityGetTransform(player)
    py = py - 6
    local distance = math.sqrt((px - x)^2  + (py - y)^2)
    if distance <= 8 then
        EntityInflictDamage(player, 0.04 * (1 + level), "DAMAGE_CURSE", "Haunted", "DISINTEGRATED", 0, 0, this, px, py, 0)
    end
    --- attacking
    local comp_frame = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "frame_next_attack")
    local frame_attack = ComponentGetValue2(comp_frame, "value_int")
    if frame_now >= frame_attack then
        if distance <= 34 then
            local tx, ty = px, py - 2
            if not RaytraceSurfaces(x, y, tx, ty) then
                local cd = math.max(32 - 4 * level, 16) 
                ComponentSetValue2(comp_frame, "value_int", frame_now + cd)
                local dist_x = x - tx
			    local dist_y = y - ty
        		local arc = math.atan(dist_y / dist_x)
        		local vel_x = dist_y / math.tan(arc) * -110
			    local vel_y = math.tan(arc) * dist_x * -110
			    local proj = shoot_projectile(this, "mods/souls/files/entities/animals/haunting/wave_projectile.xml", x, y, vel_x, vel_y)
            end
        else
            local tx, ty = px, py - 2
            if not RaytraceSurfacesAndLiquiform(x, y, tx, ty) then
                ComponentSetValue2(comp_frame, "value_int", frame_now + 40 + Random(level * -2, 50))
        		local count = level
		        local dist_x = x - tx
			    local dist_y = y - ty
        		for i=1,count do
        			SetRandomSeed(x + tx + i, y - ty)
        			local arc = math.atan(dist_y / dist_x) + Random(-16, 16) * 0.0003 * math.pi * 2
        			local vel_x = dist_y / math.tan(arc) * -70
			        local vel_y = math.tan(arc) * dist_x * -70
			        local proj = shoot_projectile(this, "mods/souls/files/entities/animals/haunting/flare_projectile.xml", x, y, vel_x, vel_y)
		        end
	        end
        end
    end
    --- movement
    py = py - 10 * (math.sin(frame_now / 30) + 0.8)
    local speed = 0.008
    if distance < 70 then
        speed = speed - 0.006 * (1 - distance/70)
    end
    local dist_x = x - px
    local dist_y = y - py
    local angle = math.atan(dist_y / dist_x)
    local mx = x + -speed * (dist_y / math.tan(angle))
    local my = y + -speed * (math.tan(angle) * dist_x)
    EntityApplyTransform(this, mx, my)
end