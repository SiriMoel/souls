local this = GetUpdatedEntityID()

local x, y, r = EntityGetTransform(this)

local frame = GameGetFrameNum()

local comp_sprite = EntityGetFirstComponentIncludingDisabled(this, "SpriteComponent")
local alpha = 0.6 + 0.3 * math.sin(frame / 20)
ComponentSetValue2(comp_sprite, "alpha", alpha)

local comp_frame_created = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "frame_created")
if comp_frame_created == nil then EntityKill(this) return end -- comment this when im not trying to maintain a run
local frame_created = ComponentGetValue2(comp_frame_created, "value_int")
local frame_now = GameGetFrameNum()

if frame_now > frame_created + 7200 then
    EntityKill(this)
end

local comp_speed = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "speed")
local speed = ComponentGetValue2(comp_speed, "value_float")

local min_speed = 0
local normal_speed = 1.0
local max_speed = 2.0
local speed_inc = 0.02

local stop_dist = 10

local a = -math.pi / 2

if frame_now <= frame_created + 30 then
    local up = (frame_now - frame_created) / 30
    speed = normal_speed * math.sin(math.pi * up)
else
    local targets = EntityGetInRadiusWithTag(x, y, 200, "player_unit") or {}
    if #targets > 0 then
        local player = targets[1]

        local p_x, p_y = EntityGetTransform(player)
        p_y = p_y - 5

        if RaytraceSurfaces(x, y, p_x, p_y) then
            speed = math.max(speed - speed_inc, min_speed)
        else
            speed = math.min(speed + 2 * speed_inc, max_speed)
        end

        local dist_x = p_x - x
        local dist_y = p_y - y

        local dist_xy = math.sqrt(dist_x*dist_x + dist_y*dist_y)

        a = math.atan2(dist_y, dist_x)
    else
        speed = math.max(speed - 5 * speed_inc, min_speed)
    end
end

if RaytraceSurfaces(x, y, x + stop_dist * math.cos(a), y + stop_dist * math.sin(a)) then
    speed = math.max(speed - 10 * speed_inc, min_speed)
elseif RaytraceSurfaces(x, y, x + 3 * math.cos(a), y + 3 * math.sin(a)) then
    speed = min_speed
end

ComponentSetValue2(comp_speed, "value_float", speed)

local new_x = x + speed * math.cos(a)
local new_y = y + speed * math.sin(a)
--local new_r = r - 0.2 * a -- yeah idk

EntityApplyTransform(this, new_x, new_y)