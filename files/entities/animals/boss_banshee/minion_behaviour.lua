local this = GetUpdatedEntityID()
local x, y, r = EntityGetTransform(this)

local targets = EntityGetInRadiusWithTag(x, y, 250, "player_unit") or {}

if #targets > 0 then
    local comp_speed = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "speed")
    local speed = ComponentGetValue2(comp_speed, "value_float")

    local player = targets[1]

    local p_x, p_y = EntityGetTransform(player)
    p_y = p_y - 5

    local dist_x = p_x - x
    local dist_y = p_y - y

    local dist_xy = math.sqrt(dist_x*dist_x + dist_y*dist_y)

    if dist_xy <= 8 then
        speed = math.max(speed - 0.03, 0.3)
    elseif dist_xy >= 50 then
        speed = math.min(speed + 0.04, 1.4)
    elseif dist_xy >= 15 then
        speed = math.min(speed + 0.03, 1.4)
    end
    ComponentSetValue2(comp_speed, "value_float", speed)

    local a = math.atan2(dist_y, dist_x)

    local new_x = x + speed * math.cos(a)
    local new_y = y + speed * math.sin(a)

    local angle_diff = a - r
    local new_r = r + angle_diff * 0.4

    EntityApplyTransform(this, new_x, new_y, new_r)
end