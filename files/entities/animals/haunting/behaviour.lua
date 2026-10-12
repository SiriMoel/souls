local this = GetUpdatedEntityID()
local comp_level = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "haunting_level")
local level = ComponentGetValue2(comp_level, "value_int")
local x, y = EntityGetTransform(this)
local targets = EntityGetInRadiusWithTag(x, y, 500, "player_unit") or {}
if #targets > 0 then
    local frame_now = GameGetFrameNum()
    SetRandomSeed(x + this, y + frame_now)
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
        -- attack!
        if distance <= 35 then
            ComponentSetValue2(comp_frame, "value_int", frame_now + 12)
        else
            ComponentSetValue2(comp_frame, "value_int", frame_now + 40)
        end
    end
    --- movement
    py = py - 10 * (math.sin(frame_now / 30) + 0.8)
    local speed = 0.016
    if distance <= 70 then
        speed = speed - 0.006 * (1 - distance/70)
    end
    local dist_x = x - px
    local dist_y = y - py
    local angle = math.atan(dist_y / dist_x)
    local mx = x + -speed * (dist_y / math.tan(angle))
    local my = y + -speed * (math.tan(angle) * dist_x)
    EntityApplyTransform(this, mx, my)
end