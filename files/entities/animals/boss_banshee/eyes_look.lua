local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)

local comp_looking = EntityGetFirstComponent(this, "SpriteComponent", "eyes_looking")

if comp_looking == nil then return end

local offset_x = 0
local offset_y = 0

local targets = EntityGetInRadiusWithTag(x, y, 300, "player_unit") or {}
if #targets > 0 then
    local target = targets[1]
    local t_x, t_y = EntityGetTransform(target)
    t_y = t_y - 5

    local dist_x = x - t_x
    local dist_y = y - t_y

    local a = math.atan2(dist_y, dist_x)

    offset_x = offset_x + math.cos(a) * -2
    offset_y = offset_y + math.sin(a) * -2
end

ComponentSetValue2(comp_looking, "transform_offset", offset_x, offset_y)