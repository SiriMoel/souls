local this = GetUpdatedEntityID()
local x, y, r, scale_x, scale_y = EntityGetTransform(this)

local targets = EntityGetInRadiusWithTag(x, y, 300, "player_unit") or {}

if #targets == 0 then return end

local px, py = EntityGetTransform(targets[1])

local movespeed = 0.2

local dist_p_t = 10

local tx, ty = px, py

local theta = (math.pi / 2) - math.atan(y - py, x - px)

tx = ((dist_p_t * math.sin(theta)) / math.sin(math.pi / 2)) + py
ty = ((dist_p_t * math.sin((math.pi / 2) - theta)) / math.sin(math.pi / 2)) + py

local dist_t = math.sqrt(((tx - x)^2) + ((ty - y)^2))

if dist_t > 0 then
    if x <= px then
        x = x + movespeed
    else
        x = x - movespeed
    end
    if y <= py then
        y = y + movespeed
    else
        y = y - movespeed
    end
end

EntitySetTransform(this, x, y, r, scale_x, scale_y)