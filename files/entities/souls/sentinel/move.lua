local this = GetUpdatedEntityID()

local x, y, r = EntityGetTransform(this)

local frame = GameGetFrameNum()

local comp_sprite = EntityGetFirstComponentIncludingDisabled(this, "SpriteComponent", "character")
local alpha = 0.7 + 0.1 * math.sin(frame / 30)
ComponentSetValue2(comp_sprite, "alpha", alpha)

local comp_mode = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "mode")
local mode = ComponentGetValue2(comp_mode, "value_string")

local speed = 0.5
local default_speed = speed * 0.14 * math.sin(frame / 40)

local a = -math.pi / 2

local t_x = x
local t_y = y

if mode == "follow" then
    local targets = EntityGetInRadiusWithTag(x, y, 200, "player_unit") or {}
    if #targets > 0 then
        t_x, t_y = EntityGetTransform(targets[1])
        t_y = t_y - 22

        local dist_y = t_y - y
        local dist_x = t_x - x

        local dist_xy = math.sqrt(dist_y*dist_y + dist_x*dist_x)

        if dist_xy > 3 then
            speed = speed + 0.5 * (1 - dist_xy / 200)
            a = math.atan2(dist_y, dist_x)
        else
            speed = default_speed
        end
    else
        speed = default_speed
    end
else
    speed = default_speed
end

local sentinels = EntityGetInRadiusWithTag(x, y, 30, "souls_sentinel") or {}
if #sentinels > 1 then
    for i,v in ipairs(sentinels) do
        local s_comp_mode = EntityGetFirstComponentIncludingDisabled(v, "VariableStorageComponent", "mode")
        local s_mode = ComponentGetValue2(s_comp_mode, "value_string")
        if s_mode == "follow" and v ~= this then
            speed = default_speed
        end
    end
end

local new_x = x + speed * math.cos(a)
local new_y = y + speed * math.sin(a) 

EntitySetTransform(this, new_x, new_y)